import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/report_data.dart';
import 'chart_widget.dart';

class ReportPageGenerator {
  final ReportData reportData;
  final Map<String, pw.MemoryImage> images;

  ReportPageGenerator({
    required this.reportData,
    required this.images,
  });

  pw.Document generateReport() {
    final doc = pw.Document();

    // Only one page with visualizations
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(10),
        build: (context) => pw.Container(
          padding: const pw.EdgeInsets.all(10),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Info cards in a row - smaller and left-aligned
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  // Patient Info Card
                  pw.Container(
                    width: 150, // Fixed width for both cards
                    margin: const pw.EdgeInsets.only(right: 10),
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey),
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Patient Information', 
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)
                        ),
                        pw.Divider(),
                        _buildInfoRow('Patient ID', reportData.patientInfo?.patientId ?? 'N/A'),
                        _buildInfoRow('Personal Number', reportData.patientInfo?.personalNumber ?? 'N/A'),
                        _buildInfoRow('Contact physician', reportData.patientInfo?.contact ?? 'N/A'),
                      ],
                    ),
                  ),
                  
                  // Sample Info Card
                  pw.Container(
                    width: 150, // Fixed width for both cards
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey),
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
                    ),
            child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                        pw.Text('Info of the latest sample', 
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)
                        ),
                        pw.Divider(),
                        _buildInfoRow('Sample ID', reportData.sampleInfo?.latestSampleId ?? 'N/A'),
                        _buildInfoRow('Visit', reportData.sampleInfo?.latestVisit ?? 'N/A'),
                        _buildInfoRow('Physician', reportData.sampleInfo?.referringPhysician ?? 'N/A'),
                        _buildInfoRow('Collection', reportData.sampleInfo?.sampleCollectionLocation ?? 'N/A'),
                        _buildInfoRow('Date', reportData.sampleInfo?.dateOfSampling ?? 'N/A'),
                      ],
                    ),
                  ),
                ],
              ),
              
              pw.SizedBox(height: 5),

              pw.Header(
                child: pw.Text('ISG Score', 
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)
                ),
              ),

              pw.SizedBox(height: 5),
              
              // First figure with constrained height
              pw.Container(
                height: 300,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Expanded(
                      child: ChartWidget.buildImageWidget(images['ISG_timeline.png']),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 10),

              // Second figure with constrained height
              pw.Container(
                height: 300,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Expanded(
                      child: ChartWidget.buildImageWidget(images['ISG_scatter.png']),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4, 
        margin: const pw.EdgeInsets.all(10), 
        build: (context) => pw.Container(
          padding: const pw.EdgeInsets.all(10),
          child: pw.Column(
            children: [
              pw.Header(
                child: pw.Text('ISG Score',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 12)),
              ),

              pw.SizedBox(height: 5),
              
              // ISG Score Table
              pw.Container(
                child: _buildISGScoreTable(reportData.isgScore),
              ),
            ],
          ),
        ),
      ),
    );

    // NFkb Figures Page (Page 3)
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(10),
        build: (context) => pw.Container(
          padding: const pw.EdgeInsets.all(10),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                child: pw.Text('NFkb Score',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)
                ),
              ),
              pw.SizedBox(height: 5),
              
              // First NFkb figure
              pw.Container(
                height: 300,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Expanded(
                      child: ChartWidget.buildImageWidget(images['NFkb_timeline.png']),
                    ),
                  ],
                ),
              ),
              
              pw.SizedBox(height: 10),
              
              // Second NFkb figure
              pw.Container(
                height: 300,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Expanded(
                      child: ChartWidget.buildImageWidget(images['NFkb_scatter.png']),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // NFkb Table Page (Page 4)
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(10),
        build: (context) => pw.Container(
          padding: const pw.EdgeInsets.all(10),
          child: pw.Column(
            children: [
              pw.Header(
                child: pw.Text('NFkb Score',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)
                ),
              ),
              pw.SizedBox(height: 5),
              
              // NFkb Score Table
              pw.Container(
                child: _buildNFkbScoreTable(reportData.nfkbScore),
              ),
            ],
          ),
        ),
      ),
    );

    // IFNg Figures Page (Page 5)
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(10),
        build: (context) => pw.Container(
          padding: const pw.EdgeInsets.all(10),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                child: pw.Text('IFNg Score',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)
                ),
              ),
              pw.SizedBox(height: 5),
              
              // First IFNg figure
              pw.Container(
                height: 300,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Expanded(
                      child: ChartWidget.buildImageWidget(images['IFNg_timeline.png']),
                    ),
                  ],
                ),
              ),
              
              pw.SizedBox(height: 10),
              
              // Second IFNg figure
              pw.Container(
                height: 300,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Expanded(
                      child: ChartWidget.buildImageWidget(images['IFNg_scatter.png']),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // IFNg Table Page (Page 6)
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(10),
        build: (context) => pw.Container(
          padding: const pw.EdgeInsets.all(10),
          child: pw.Column(
            children: [
              pw.Header(
                child: pw.Text('IFNg Score',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)
                ),
              ),
              pw.SizedBox(height: 5),
              
              // IFNg Score Table
              pw.Container(
                child: _buildIFNgScoreTable(reportData.ifngScore),
              ),
            ],
          ),
        ),
      ),
    );

    // Protocol Page (Page 7)
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(10),
        build: (context) => pw.Container(
          padding: const pw.EdgeInsets.all(10),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Main header
              pw.Header(
                level: 0,
                child: pw.Text('Protocol', 
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  )
                ),
              ),
              pw.SizedBox(height: 10),
              
              // Sample processing section
              pw.Header(
                level: 1,
                child: pw.Text('Sample processing', 
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  )
                ),
              ),
              pw.Paragraph(
                text: 'Blood drawn in an EDTA tube is, as soon as possible, aliquoted and mixed with PAXgene buffer in a 100:276 blood to PAXgene ratio, i.e. for 1 ml of blood, 2.76 ml of PAXgene buffer are used. After thoroughly mixing, the PAXgene sample is left at RT for a minimum of 1h to ensure blood cell lysis and then frozen at -80ºC until its use for RNA isolation.',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 10),
              
              // RNA isolation section
              pw.Header(
                level: 1,
                child: pw.Text('RNA isolation', 
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  )
                ),
              ),
              pw.Paragraph(
                text: 'The PAXgene sample previously frozen at -80ºC is thawed and equilibrated at RT for 30 min - 1h. Then, the protocol from PreAnalytix for the automated RNA purification from PAXgene samples is followed. Briefly, the sample is centrifuged twice, and the cell pellet resuspended in a buffer provided in the PAXgene kit. The following column-based purification steps for RNA isolation are performed automatically in the QIAcube (liquid handling platform from QIAGEN). Two aliquots of the eluted RNA are taken for the subsequent concentration measurement and integrity check. The remaining sample is frozen at -80ºC until its use for gene expression analyses.',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 10),
              
              // Gene expression analyses section
              pw.Header(
                level: 1,
                child: pw.Text('Gene expression analyses', 
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  )
                ),
              ),
              pw.Paragraph(
                text: 'The gene expression levels of 56 immune-related genes and 3 housekeeping genes are measured using NanoString Technologies. For this, a hybridization reaction between the mRNA molecules in the sample and a set of oligonucleotide probes, designed to capture the specific genes of interest, is carried out following NanoString\'s recommendations. Briefly, around 5 µl of RNA sample are mixed with the oligonucleotide probes and incubated in a thermocycler at 65ºC, with a heated lid at 70ºC, for 20h. Once the reaction time is completed, the sample is loaded into a cartridge designed to be read by NanoString\'s nCounter instrument. The cartridge is then placed inside the nCounter and the gene expression assay is carried out within the instrument, which in the end provides a readout with raw mRNA counts of the genes of study.',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.Paragraph(
                text: 'Clinical samples, along with healthy donor reference samples, are run in the nCounter in batches of 12.',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 10),
              
              // Gene expression data analysis section
              pw.Header(
                level: 1,
                child: pw.Text('Gene expression data analysis', 
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  )
                ),
              ),
              pw.Paragraph(
                text: 'First, a quality check of the data is done by the nSolver software provided by NanoString. Then, as recommended by Nanostring, the data is pre-processed in two different normalization steps: 1. Internal positive control normalization. 2. Housekeeping genes normalization.',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.Paragraph(
                text: 'After normalization, two different scores (Z-score and geomean score) are calculated to provide a summary of the expression levels of type I IFN--stimulated genes (ISG scores), NF-kB--regulated genes (NF-kB scores) and type II IFN--regulated genes (IFN-gamma scores)1,2. Of note, NanoString\'s products, along with any assays developed with its components are intended for research purposes only.',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 10),
              
              // References section
              pw.Header(
                level: 1,
                child: pw.Text('References', 
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  )
                ),
              ),
              pw.Paragraph(
                text: '1. Kim, H., de Jesus, A. A., Brooks, S. R., Liu, Y., Huang, Y., VanTries, R., ... & Goldbach-Mansky, R. (2018). Development of a validated interferon score using NanoString technology. Journal of Interferon & Cytokine Research, 38(4), 171-185.',
                style: pw.TextStyle(fontSize: 9),
              ),
              pw.Paragraph(
                text: '2. Abers, M. S., Delmonte, O. M., Ricotta, E. E., Fintzi, J., Fink, D. L., de Jesus, A. A. A., ... & NIAID COVID-19 Consortium. (2021). An immune-based biomarker signature is associated with mortality in COVID-19 patients. JCI insight, 6(1).',
                style: pw.TextStyle(fontSize: 9),
              ),
            ],
          ),
        ),
      ),
    );
    return doc;
  }



  
  // Helper method to build info rows - make them more compact
  pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 60, // Smaller label width
            child: pw.Text(label + ':', 
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9)
            ),
          ),
          pw.Expanded(
            child: pw.Text(value, style: pw.TextStyle(fontSize: 9)),
          ),
        ],
      ),
    );
  }
  
  // Build ISG Score Table
  pw.Widget _buildISGScoreTable(List<ISGScore>? isgScores) {
    if (isgScores == null || isgScores.isEmpty) {
      return pw.Text('No ISG score data available',
        style: pw.TextStyle(
          fontStyle: pw.FontStyle.italic,
          color: PdfColors.grey700,
          fontSize: 8,
        )
      );
    }
    
    // Get all column names (visit IDs)
    final List<String> columnNames = [];
    if (isgScores.isNotEmpty && isgScores[0].data.isNotEmpty) {
      columnNames.addAll(isgScores[0].data.keys.where((key) => key != '_row'));
    }
    
    // Create table
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey, width: 0.5),
      defaultColumnWidth: const pw.FixedColumnWidth(40),
      tableWidth: pw.TableWidth.min,
      children: [
        // Header row
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              alignment: pw.Alignment.center,
              child: pw.Text('Gene', 
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)
              ),
            ),
            ...columnNames.map((visit) => pw.Container(
              padding: const pw.EdgeInsets.all(2),
              alignment: pw.Alignment.center,
              child: pw.Text(visit.replaceAll('ISG-6_', ''), 
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)
              ),
            )),
          ],
        ),
        
        // Data rows
        ...isgScores.map((score) => pw.TableRow(
          children: [
            // Gene name column
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(score.rowName, 
                style: pw.TextStyle(fontSize: 6, fontWeight: score.rowName == 'geomean' || score.rowName == 'zscore' ? pw.FontWeight.bold : pw.FontWeight.normal)
              ),
            ),
            
            // Value columns
            ...columnNames.map((visit) => pw.Container(
              padding: const pw.EdgeInsets.all(2),
              alignment: pw.Alignment.center,
              child: pw.Text(
                score.data[visit]?.toString() ?? '-', 
                style: pw.TextStyle(
                  fontSize: 6,
                  fontWeight: score.rowName == 'geomean' || score.rowName == 'zscore' ? pw.FontWeight.bold : pw.FontWeight.normal,
                  color: PdfColors.black,
                )
              ),
            )),
          ],
        )),
      ],
    );
  }

  // Build NFkb Score Table
  pw.Widget _buildNFkbScoreTable(List<NFkbScore>? nfkbScores) {
    if (nfkbScores == null || nfkbScores.isEmpty) {
      return pw.Text('No NFkb score data available',
        style: pw.TextStyle(
          fontStyle: pw.FontStyle.italic,
          color: PdfColors.grey700,
          fontSize: 8,
        )
      );
    }
    
    // Get all column names (visit IDs)
    final List<String> columnNames = [];
    if (nfkbScores.isNotEmpty && nfkbScores[0].data.isNotEmpty) {
      columnNames.addAll(nfkbScores[0].data.keys.where((key) => key != '_row'));
    }
    
    // Create table (same structure as ISG table)
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey, width: 0.5),
      defaultColumnWidth: const pw.FixedColumnWidth(40),
      tableWidth: pw.TableWidth.min,
      children: [
        // Header row
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              alignment: pw.Alignment.center,
              child: pw.Text('Gene', 
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)
              ),
            ),
            ...columnNames.map((visit) => pw.Container(
              padding: const pw.EdgeInsets.all(2),
              alignment: pw.Alignment.center,
              child: pw.Text(visit.replaceAll('ISG-6_', ''), 
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)
              ),
            )),
          ],
        ),
        
        // Data rows
        ...nfkbScores.map((score) => pw.TableRow(
          children: [
            // Gene name column
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(score.rowName, 
                style: pw.TextStyle(fontSize: 6, fontWeight: score.rowName == 'geomean' || score.rowName == 'zscore' ? pw.FontWeight.bold : pw.FontWeight.normal)
              ),
            ),
            
            // Value columns
            ...columnNames.map((visit) => pw.Container(
              padding: const pw.EdgeInsets.all(2),
              alignment: pw.Alignment.center,
              child: pw.Text(
                score.data[visit]?.toString() ?? '-', 
                style: pw.TextStyle(
                  fontSize: 6,
                  fontWeight: score.rowName == 'geomean' || score.rowName == 'zscore' ? pw.FontWeight.bold : pw.FontWeight.normal,
                  color: PdfColors.black,
                )
              ),
            )),
          ],
        )),
      ],
    );
  }

  // Build IFNg Score Table
  pw.Widget _buildIFNgScoreTable(List<IFNgScore>? ifngScores) {
    if (ifngScores == null || ifngScores.isEmpty) {
      return pw.Text('No IFNg score data available',
        style: pw.TextStyle(
          fontStyle: pw.FontStyle.italic,
          color: PdfColors.grey700,
          fontSize: 8,
        )
      );
    }
    
    // Get all column names (visit IDs)
    final List<String> columnNames = [];
    if (ifngScores.isNotEmpty && ifngScores[0].data.isNotEmpty) {
      columnNames.addAll(ifngScores[0].data.keys.where((key) => key != '_row'));
    }
    
    // Create table (same structure as ISG table)
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey, width: 0.5),
      defaultColumnWidth: const pw.FixedColumnWidth(40),
      tableWidth: pw.TableWidth.min,
      children: [
        // Header row
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              alignment: pw.Alignment.center,
              child: pw.Text('Gene', 
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)
              ),
            ),
            ...columnNames.map((visit) => pw.Container(
              padding: const pw.EdgeInsets.all(2),
              alignment: pw.Alignment.center,
              child: pw.Text(visit.replaceAll('ISG-6_', ''), 
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)
              ),
            )),
          ],
        ),
        
        // Data rows
        ...ifngScores.map((score) => pw.TableRow(
          children: [
            // Gene name column
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(score.rowName, 
                style: pw.TextStyle(fontSize: 6, fontWeight: score.rowName == 'geomean' || score.rowName == 'zscore' ? pw.FontWeight.bold : pw.FontWeight.normal)
              ),
            ),
            
            // Value columns
            ...columnNames.map((visit) => pw.Container(
              padding: const pw.EdgeInsets.all(2),
              alignment: pw.Alignment.center,
              child: pw.Text(
                score.data[visit]?.toString() ?? '-', 
                style: pw.TextStyle(
                  fontSize: 6,
                  fontWeight: score.rowName == 'geomean' || score.rowName == 'zscore' ? pw.FontWeight.bold : pw.FontWeight.normal,
                  color: PdfColors.black,
                )
              ),
            )),
          ],
        )),
      ],
    );
  }
}
