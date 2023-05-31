// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      road_address: json['road_address'] == null
          ? null
          : DocumentRoadAddress.fromJson(
              json['road_address'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : DocumentAddress.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'road_address': instance.road_address,
      'address': instance.address,
    };
