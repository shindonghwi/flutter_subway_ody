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
      place_name: json['place_name'] as String?,
      distance: json['distance'] as String?,
      x: json['x'] as String?,
      y: json['y'] as String?,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'road_address': instance.road_address,
      'address': instance.address,
      'place_name': instance.place_name,
      'distance': instance.distance,
      'x': instance.x,
      'y': instance.y,
    };
