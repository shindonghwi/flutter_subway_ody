// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      region_type: json['region_type'] as String?,
      address_name: json['address_name'] as String?,
      region_1depth_name: json['region_1depth_name'] as String?,
      region_2depth_name: json['region_2depth_name'] as String?,
      region_3depth_name: json['region_3depth_name'] as String?,
      region_4depth_name: json['region_4depth_name'] as String?,
      x: (json['x'] as num?)?.toDouble(),
      y: (json['y'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'region_type': instance.region_type,
      'address_name': instance.address_name,
      'region_1depth_name': instance.region_1depth_name,
      'region_2depth_name': instance.region_2depth_name,
      'region_3depth_name': instance.region_3depth_name,
      'region_4depth_name': instance.region_4depth_name,
      'x': instance.x,
      'y': instance.y,
    };
