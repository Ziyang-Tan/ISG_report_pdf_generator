import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'services/data_loader.dart';
import 'widgets/report_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Report Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReportGeneratorScreen(),
    );
  }
}

class ReportGeneratorScreen extends StatefulWidget {
  @override
  _ReportGeneratorScreenState createState() => _ReportGeneratorScreenState();
}

class _ReportGeneratorScreenState extends State<ReportGeneratorScreen> {
  final DataLoader _dataLoader = DataLoader();
  bool _isLoading = false;
  String _statusMessage = '';
  Uint8List? _pdfBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Report Generator'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : _generateReport,
                  child: Text('Generate PDF Report'),
                ),
                SizedBox(width: 20),
                _isLoading ? CircularProgressIndicator() : Text(_statusMessage),
              ],
            ),
          ),
          Expanded(
            child: _pdfBytes != null
                ? PdfPreview(
                    build: (format) => _pdfBytes!,
                    allowPrinting: true,
                    allowSharing: true,
                    canChangePageFormat: false,
                  )
                : Center(
                    child: Text('Generate a PDF to see preview here'),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateReport() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Loading data...';
    });

    try {
      // Load report data
      final reportData = await _dataLoader.loadReportData();

      setState(() {
        _statusMessage = 'Loading images...';
      });

      // Load images
      final Map<String, pw.MemoryImage> images = {};
      final histogramData = await _dataLoader.loadImageData(reportData.plots.histogram);
      final scatterData = await _dataLoader.loadImageData(reportData.plots.scatter);

      // Debug print
      print('Histogram image size: ${histogramData.length} bytes');
      print('Scatter image size: ${scatterData.length} bytes');

      images[reportData.plots.histogram] = pw.MemoryImage(histogramData);
      images[reportData.plots.scatter] = pw.MemoryImage(scatterData);

      setState(() {
        _statusMessage = 'Generating PDF...';
      });

      // Create report pages
      final reportPageGenerator = ReportPageGenerator(
        reportData: reportData,
        images: images,
      );

      // Generate PDF directly
      final pdf = reportPageGenerator.generateReport();
      
      // Save PDF bytes
      _pdfBytes = await pdf.save();

      setState(() {
        _isLoading = false;
        _statusMessage = 'PDF generated successfully';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Error generating report: $e';
        _pdfBytes = null;
      });
      print('Error: $e');
    }
  }
}
