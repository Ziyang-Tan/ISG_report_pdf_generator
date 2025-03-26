// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportData _$ReportDataFromJson(Map<String, dynamic> json) => ReportData(
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      patientInfo: json['patient_info'] == null
          ? null
          : PatientInfo.fromJson(json['patient_info'] as Map<String, dynamic>),
      sampleInfo: json['sample_info'] == null
          ? null
          : SampleInfo.fromJson(json['sample_info'] as Map<String, dynamic>),
      isgScore: (json['ISG_score'] as List<dynamic>?)
          ?.map((e) => ISGScore.fromJson(e as Map<String, dynamic>))
          .toList(),
      nfkbScore: (json['NFkb_score'] as List<dynamic>?)
          ?.map((e) => NFkbScore.fromJson(e as Map<String, dynamic>))
          .toList(),
      ifngScore: (json['IFNg_score'] as List<dynamic>?)
          ?.map((e) => IFNgScore.fromJson(e as Map<String, dynamic>))
          .toList(),
      summaryStatistics: (json['summary_statistics'] as List<dynamic>?)
              ?.map((e) => SummaryStatistic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      plots: json['plots'] == null
          ? null
          : Plots.fromJson(json['plots'] as Map<String, dynamic>),
      rawData: (json['raw_data'] as List<dynamic>?)
              ?.map((e) => RawData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ReportDataToJson(ReportData instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'patient_info': instance.patientInfo,
      'sample_info': instance.sampleInfo,
      'ISG_score': instance.isgScore,
      'NFkb_score': instance.nfkbScore,
      'IFNg_score': instance.ifngScore,
      'summary_statistics': instance.summaryStatistics,
      'plots': instance.plots,
      'raw_data': instance.rawData,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      title: json['title'] as String,
      date: json['date'] as String,
      author: json['author'] as String,
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'title': instance.title,
      'date': instance.date,
      'author': instance.author,
    };

SummaryStatistic _$SummaryStatisticFromJson(Map<String, dynamic> json) =>
    SummaryStatistic(
      group: json['group'] as String,
      count: (json['count'] as num).toInt(),
      meanValue1: (json['mean_value1'] as num).toDouble(),
      sdValue1: (json['sd_value1'] as num).toDouble(),
      meanValue2: (json['mean_value2'] as num).toDouble(),
      sdValue2: (json['sd_value2'] as num).toDouble(),
    );

Map<String, dynamic> _$SummaryStatisticToJson(SummaryStatistic instance) =>
    <String, dynamic>{
      'group': instance.group,
      'count': instance.count,
      'mean_value1': instance.meanValue1,
      'sd_value1': instance.sdValue1,
      'mean_value2': instance.meanValue2,
      'sd_value2': instance.sdValue2,
    };

Plots _$PlotsFromJson(Map<String, dynamic> json) => Plots(
      histogram: json['histogram'] as String,
      scatter: json['scatter'] as String,
    );

Map<String, dynamic> _$PlotsToJson(Plots instance) => <String, dynamic>{
      'histogram': instance.histogram,
      'scatter': instance.scatter,
    };

RawData _$RawDataFromJson(Map<String, dynamic> json) => RawData(
      id: (json['id'] as num).toInt(),
      group: json['group'] as String,
      value1: (json['value1'] as num).toDouble(),
      value2: (json['value2'] as num).toDouble(),
    );

Map<String, dynamic> _$RawDataToJson(RawData instance) => <String, dynamic>{
      'id': instance.id,
      'group': instance.group,
      'value1': instance.value1,
      'value2': instance.value2,
    };

PatientInfo _$PatientInfoFromJson(Map<String, dynamic> json) => PatientInfo(
      patientId: json['Patient_ID'] as String,
      personalNumber: json['personal_number'] as String,
      contact: json['Contact'] as String,
    );

Map<String, dynamic> _$PatientInfoToJson(PatientInfo instance) =>
    <String, dynamic>{
      'Patient_ID': instance.patientId,
      'personal_number': instance.personalNumber,
      'Contact': instance.contact,
    };

SampleInfo _$SampleInfoFromJson(Map<String, dynamic> json) => SampleInfo(
      patientId: json['Patient_ID'] as String,
      latestSampleId: json['latest_Sample_ID'] as String,
      latestVisit: json['latest_visit'] as String,
      referringPhysician: json['referring_physician'] as String,
      sampleCollectionLocation: json['Sample_collection_location'] as String,
      dateOfSampling: json['date_of_sampling'] as String,
    );

Map<String, dynamic> _$SampleInfoToJson(SampleInfo instance) =>
    <String, dynamic>{
      'Patient_ID': instance.patientId,
      'latest_Sample_ID': instance.latestSampleId,
      'latest_visit': instance.latestVisit,
      'referring_physician': instance.referringPhysician,
      'Sample_collection_location': instance.sampleCollectionLocation,
      'date_of_sampling': instance.dateOfSampling,
    };

ISGScore _$ISGScoreFromJson(Map<String, dynamic> json) => ISGScore(
      rowName: json['_row'] as String,
    );

Map<String, dynamic> _$ISGScoreToJson(ISGScore instance) => <String, dynamic>{
      '_row': instance.rowName,
    };

NFkbScore _$NFkbScoreFromJson(Map<String, dynamic> json) => NFkbScore(
      rowName: json['_row'] as String,
    );

Map<String, dynamic> _$NFkbScoreToJson(NFkbScore instance) => <String, dynamic>{
      '_row': instance.rowName,
    };

IFNgScore _$IFNgScoreFromJson(Map<String, dynamic> json) => IFNgScore(
      rowName: json['_row'] as String,
    );

Map<String, dynamic> _$IFNgScoreToJson(IFNgScore instance) => <String, dynamic>{
      '_row': instance.rowName,
    };
