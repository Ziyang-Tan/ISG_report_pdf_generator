import 'package:json_annotation/json_annotation.dart';

part 'report_data.g.dart';

@JsonSerializable()
class ReportData {
  final Metadata? metadata;
  
  @JsonKey(name: 'patient_info')
  final PatientInfo? patientInfo;
  
  @JsonKey(name: 'sample_info')
  final SampleInfo? sampleInfo;
  
  @JsonKey(name: 'ISG_score')
  final List<ISGScore>? isgScore;
  
  @JsonKey(name: 'NFkb_score')
  final List<NFkbScore>? nfkbScore;
  
  @JsonKey(name: 'IFNg_score')
  final List<IFNgScore>? ifngScore;
  
  @JsonKey(name: 'summary_statistics')
  final List<SummaryStatistic>? summaryStatistics;
  
  final Plots? plots;
  
  @JsonKey(name: 'raw_data')
  final List<RawData>? rawData;

  ReportData({
    this.metadata,
    this.patientInfo,
    this.sampleInfo,
    this.isgScore,
    this.nfkbScore,
    this.ifngScore,
    this.summaryStatistics = const [],
    this.plots,
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

@JsonSerializable()
class PatientInfo {
  @JsonKey(name: 'Patient_ID')
  final String patientId;
  
  @JsonKey(name: 'personal_number')
  final String personalNumber;
  
  @JsonKey(name: 'Contact')
  final String contact;

  PatientInfo({
    required this.patientId,
    required this.personalNumber,
    required this.contact,
  });

  factory PatientInfo.fromJson(Map<String, dynamic> json) =>
      _$PatientInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PatientInfoToJson(this);
}

@JsonSerializable()
class SampleInfo {
  @JsonKey(name: 'Patient_ID')
  final String patientId;
  
  @JsonKey(name: 'latest_Sample_ID')
  final String latestSampleId;
  
  @JsonKey(name: 'latest_visit')
  final String latestVisit;
  
  @JsonKey(name: 'referring_physician')
  final String referringPhysician;
  
  @JsonKey(name: 'Sample_collection_location')
  final String sampleCollectionLocation;
  
  @JsonKey(name: 'date_of_sampling')
  final String dateOfSampling;

  SampleInfo({
    required this.patientId,
    required this.latestSampleId,
    required this.latestVisit,
    required this.referringPhysician,
    required this.sampleCollectionLocation,
    required this.dateOfSampling,
  });

  factory SampleInfo.fromJson(Map<String, dynamic> json) =>
      _$SampleInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SampleInfoToJson(this);
}

@JsonSerializable()
class ISGScore {
  @JsonKey(name: '_row')
  final String rowName;
  
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> data;
  
  ISGScore({
    required this.rowName,
    Map<String, dynamic>? data,
  }) : data = data ?? {};
  
  factory ISGScore.fromJson(Map<String, dynamic> json) {
    final rowName = json['_row'] as String;
    final data = Map<String, dynamic>.from(json);
    return ISGScore(rowName: rowName, data: data);
  }
  
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll(data);
    result['_row'] = rowName;
    return result;
  }
}

@JsonSerializable()
class NFkbScore {
  @JsonKey(name: '_row')
  final String rowName;
  
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> data;
  
  NFkbScore({
    required this.rowName,
    Map<String, dynamic>? data,
  }) : data = data ?? {};
  
  factory NFkbScore.fromJson(Map<String, dynamic> json) {
    final rowName = json['_row'] as String;
    final data = Map<String, dynamic>.from(json);
    return NFkbScore(rowName: rowName, data: data);
  }
  
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll(data);
    result['_row'] = rowName;
    return result;
  }
}

@JsonSerializable()
class IFNgScore {
  @JsonKey(name: '_row')
  final String rowName;
  
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> data;
  
  IFNgScore({
    required this.rowName,
    Map<String, dynamic>? data,
  }) : data = data ?? {};
  
  factory IFNgScore.fromJson(Map<String, dynamic> json) {
    final rowName = json['_row'] as String;
    final data = Map<String, dynamic>.from(json);
    return IFNgScore(rowName: rowName, data: data);
  }
  
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll(data);
    result['_row'] = rowName;
    return result;
  }
}
