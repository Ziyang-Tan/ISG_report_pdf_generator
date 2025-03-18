// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportData _$ReportDataFromJson(Map<String, dynamic> json) => ReportData(
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      summaryStatistics: (json['summary_statistics'] as List<dynamic>?)
              ?.map((e) => SummaryStatistic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      plots: Plots.fromJson(json['plots'] as Map<String, dynamic>),
      rawData: (json['raw_data'] as List<dynamic>?)
              ?.map((e) => RawData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ReportDataToJson(ReportData instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
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
