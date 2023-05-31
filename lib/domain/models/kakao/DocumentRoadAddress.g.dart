// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DocumentRoadAddress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentRoadAddress _$DocumentRoadAddressFromJson(Map<String, dynamic> json) =>
    DocumentRoadAddress(
      address_name: json['address_name'] as String?,
      region_1depth_name: json['region_1depth_name'] as String?,
      region_2depth_name: json['region_2depth_name'] as String?,
      region_3depth_name: json['region_3depth_name'] as String?,
      road_name: json['road_name'] as String?,
      underground_yn: json['underground_yn'] as String?,
      main_building_no: json['main_building_no'] as String?,
      sub_building_no: json['sub_building_no'] as String?,
      building_name: json['building_name'] as String?,
      zone_no: json['zone_no'] as String?,
    );

Map<String, dynamic> _$DocumentRoadAddressToJson(
        DocumentRoadAddress instance) =>
    <String, dynamic>{
      'address_name': instance.address_name,
      'region_1depth_name': instance.region_1depth_name,
      'region_2depth_name': instance.region_2depth_name,
      'region_3depth_name': instance.region_3depth_name,
      'road_name': instance.road_name,
      'underground_yn': instance.underground_yn,
      'main_building_no': instance.main_building_no,
      'sub_building_no': instance.sub_building_no,
      'building_name': instance.building_name,
      'zone_no': instance.zone_no,
    };
