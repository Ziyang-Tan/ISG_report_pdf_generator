import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import '../models/report_data.dart';

class DataLoader {
  Future<ReportData> loadReportData() async {
    try {
      // Load JSON data from assets
      final String jsonString = await rootBundle.loadString('assets/data/ISG_analysis_report.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      // Ensure minimal structure exists
      if (!jsonData.containsKey('metadata')) {
        jsonData['metadata'] = {
          "title": "ISG Analysis Report",
          "date": DateTime.now().toString().substring(0, 10),
          "author": "Flutter Report Generator"
        };
      }
      
      return ReportData.fromJson(jsonData);
    } catch (e) {
      print('Error loading report data: $e');
      
      // Return default data on error
      return ReportData(
        metadata: Metadata(
          title: "ISG Analysis Report",
          date: DateTime.now().toString().substring(0, 10),
          author: "Flutter Report Generator"
        ),
        plots: Plots(histogram: "histogram.png", scatter: "scatter.png")
      );
    }
  }

  Future<Uint8List> loadImageData(String imagePath) async {
    try {
      final ByteData data = await rootBundle.load('assets/data/$imagePath');
      return data.buffer.asUint8List();
    } catch (e) {
      print('Error loading image data: $e');
      rethrow;
    }
  }
}
