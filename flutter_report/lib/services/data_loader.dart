import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import '../models/report_data.dart';

class DataLoader {
  Future<ReportData> loadReportData() async {
    try {
      // Load JSON data from assets
      final String jsonString = await rootBundle.loadString('assets/data/analysis_results.json');
      print('Full JSON content:');
      print(jsonString);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      // Debug print
      print('Summary statistics data: ${jsonData['summaryStatistics']}');
      
      // Print the structure of the parsed JSON
      print('JSON structure:');
      jsonData.forEach((key, value) {
        print('$key: ${value.runtimeType}');
      });
      
      return ReportData.fromJson(jsonData);
    } catch (e) {
      print('Error loading report data: $e');
      rethrow;
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
