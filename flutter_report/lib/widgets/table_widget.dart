import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../models/report_data.dart';

class TableWidget {
  static pw.Widget buildSummaryTable(List<SummaryStatistic>? summaryStats) {
    // Handle null or empty list
    final stats = summaryStats ?? [];
    
    if (stats.isEmpty) {
      return pw.Text('No summary statistics available',
        style: pw.TextStyle(
          fontStyle: pw.FontStyle.italic,
          color: PdfColors.grey700,
        )
      );
    }
    
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        // Header row
        pw.TableRow(
          decoration: const pw.BoxDecoration(
            color: PdfColors.grey300,
          ),
          children: [
            _buildTableCell('Group', isHeader: true),
            _buildTableCell('Count', isHeader: true),
            _buildTableCell('Mean (Value 1)', isHeader: true),
            _buildTableCell('SD (Value 1)', isHeader: true),
            _buildTableCell('Mean (Value 2)', isHeader: true),
            _buildTableCell('SD (Value 2)', isHeader: true),
          ],
        ),
        // Data rows
        ...stats.map((stat) => pw.TableRow(
              children: [
                _buildTableCell(stat.group),
                _buildTableCell(stat.count.toString()),
                _buildTableCell(stat.meanValue1.toStringAsFixed(2)),
                _buildTableCell(stat.sdValue1.toStringAsFixed(2)),
                _buildTableCell(stat.meanValue2.toStringAsFixed(2)),
                _buildTableCell(stat.sdValue2.toStringAsFixed(2)),
              ],
            )),
      ],
    );
  }

  static pw.Widget buildRawDataTable(List<RawData>? rawData) {
    // Handle null or empty list
    final data = rawData ?? [];
    
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        // Header row
        pw.TableRow(
          decoration: const pw.BoxDecoration(
            color: PdfColors.grey300,
          ),
          children: [
            _buildTableCell('ID', isHeader: true),
            _buildTableCell('Group', isHeader: true),
            _buildTableCell('Value 1', isHeader: true),
            _buildTableCell('Value 2', isHeader: true),
          ],
        ),
        // Data rows
        ...data.map((data) => pw.TableRow(
              children: [
                _buildTableCell(data.id.toString()),
                _buildTableCell(data.group),
                _buildTableCell(data.value1.toStringAsFixed(2)),
                _buildTableCell(data.value2.toStringAsFixed(2)),
              ],
            )),
      ],
    );
  }

  static pw.Widget _buildTableCell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }
}
