// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MetaSameName.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaSameName _$MetaSameNameFromJson(Map<String, dynamic> json) => MetaSameName(
      keyword: json['keyword'] as String?,
      selected_region: json['selected_region'] as String?,
      region:
          (json['region'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MetaSameNameToJson(MetaSameName instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'selected_region': instance.selected_region,
      'region': instance.region,
    };
