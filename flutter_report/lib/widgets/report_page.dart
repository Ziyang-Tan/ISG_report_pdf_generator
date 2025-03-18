import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/report_data.dart';
import 'chart_widget.dart';
import 'table_widget.dart';

class ReportPageGenerator {
  final ReportData reportData;
  final Map<String, pw.MemoryImage> images;

  ReportPageGenerator({
    required this.reportData,
    required this.images,
  });

  pw.Document generateReport() {
    final doc = pw.Document();
    
    // Title page
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                reportData.metadata.title,
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Date: ${reportData.metadata.date}'),
              pw.Text('Author: ${reportData.metadata.author}'),
            ],
          ),
        ),
      ),
    );

    // Summary statistics page
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Container(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('Summary Statistics'),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'This section presents the summary statistics for each group in the dataset.',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
              pw.SizedBox(height: 20),
              TableWidget.buildSummaryTable(reportData.summaryStatistics),
            ],
          ),
        ),
      ),
    );

    // Visualizations page
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Container(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('Data Visualizations'),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Visual representation of the analyzed data.',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Header(
                  level: 1, child: pw.Text('Distribution of Value 1 by Group')),
              ChartWidget.buildImageWidget(images[reportData.plots.histogram]!),
              pw.SizedBox(height: 20),
              pw.Header(
                  level: 1,
                  child: pw.Text('Relationship between Value 1 and Value 2')),
              pw.Text('Image path: ${reportData.plots.scatter}'),
              (() {
                try {
                  return ChartWidget.buildImageWidget(images[reportData.plots.scatter]!);
                } catch (e) {
                  return pw.Text('Error displaying image: $e', 
                    style: pw.TextStyle(color: PdfColors.red)
                  );
                }
              })(),
            ],
          ),
        ),
      ),
    );

    // Raw data page
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Container(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('Raw Data Sample'),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'First 20 rows of the raw data used in the analysis.',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
              pw.SizedBox(height: 20),
              TableWidget.buildRawDataTable(reportData.rawData),
            ],
          ),
        ),
      ),
    );

    return doc;
  }
}
