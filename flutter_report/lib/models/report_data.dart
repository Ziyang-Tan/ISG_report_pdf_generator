import 'package:json_annotation/json_annotation.dart';

part 'report_data.g.dart';

@JsonSerializable()
class ReportData {
  final Metadata metadata;
  
  @JsonKey(name: 'summary_statistics')
  final List<SummaryStatistic>? summaryStatistics;
  
  final Plots plots;
  
  @JsonKey(name: 'raw_data')
  final List<RawData>? rawData;

  ReportData({
    required this.metadata,
    this.summaryStatistics = const [],
    required this.plots,
    this.rawData = const [],
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    if (json['summaryStatistics'] == null) {
      json['summaryStatistics'] = [];
    }
    
    if (json['rawData'] == null) {
      json['rawData'] = [];
    }
    
    return _$ReportDataFromJson(json);
  }
  
  Map<String, dynamic> toJson() => _$ReportDataToJson(this);
}

@JsonSerializable()
class Metadata {
  final String title;
  final String date;
  final String author;

  Metadata({required this.title, required this.date, required this.author});

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class SummaryStatistic {
  final String group;
  final int count;
  
  @JsonKey(name: 'mean_value1')
  final double meanValue1;
  
  @JsonKey(name: 'sd_value1')
  final double sdValue1;
  
  @JsonKey(name: 'mean_value2')
  final double meanValue2;
  
  @JsonKey(name: 'sd_value2')
  final double sdValue2;

  SummaryStatistic({
    required this.group,
    required this.count,
    required this.meanValue1,
    required this.sdValue1,
    required this.meanValue2,
    required this.sdValue2,
  });

  factory SummaryStatistic.fromJson(Map<String, dynamic> json) =>
      _$SummaryStatisticFromJson(json);
  Map<String, dynamic> toJson() => _$SummaryStatisticToJson(this);
}

@JsonSerializable()
class Plots {
  final String histogram;
  final String scatter;

  Plots({required this.histogram, required this.scatter});

  factory Plots.fromJson(Map<String, dynamic> json) => _$PlotsFromJson(json);
  Map<String, dynamic> toJson() => _$PlotsToJson(this);
}

@JsonSerializable()
class RawData {
  final int id;
  final String group;
  final double value1;
  final double value2;

  RawData({
    required this.id,
    required this.group,
    required this.value1,
    required this.value2,
  });

  factory RawData.fromJson(Map<String, dynamic> json) =>
      _$RawDataFromJson(json);
  Map<String, dynamic> toJson() => _$RawDataToJson(this);
}
