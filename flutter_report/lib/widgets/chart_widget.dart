import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class ChartWidget {
  static pw.Widget buildImageWidget(pw.MemoryImage? image) {
    if (image == null) {
      return pw.Text('Image not available',
        style: pw.TextStyle(
          fontStyle: pw.FontStyle.italic,
          color: PdfColors.grey700,
        )
      );
    }
    
    return pw.Center(
      child: pw.Container(
        child: pw.Image(image, fit: pw.BoxFit.contain),
      ),
    );
  }
}
