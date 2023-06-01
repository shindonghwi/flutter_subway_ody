// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DocumentAddress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentAddress _$DocumentAddressFromJson(Map<String, dynamic> json) =>
    DocumentAddress(
      address_name: json['address_name'] as String?,
      region_1depth_name: json['region_1depth_name'] as String?,
      region_2depth_name: json['region_2depth_name'] as String?,
      region_3depth_name: json['region_3depth_name'] as String?,
      mountain_yn: json['mountain_yn'] as String?,
      main_address_no: json['main_address_no'] as String?,
      sub_address_no: json['sub_address_no'] as String?,
      zip_code: json['zip_code'] as String?,
    );

Map<String, dynamic> _$DocumentAddressToJson(DocumentAddress instance) =>
    <String, dynamic>{
      'address_name': instance.address_name,
      'region_1depth_name': instance.region_1depth_name,
      'region_2depth_name': instance.region_2depth_name,
      'region_3depth_name': instance.region_3depth_name,
      'mountain_yn': instance.mountain_yn,
      'main_address_no': instance.main_address_no,
      'sub_address_no': instance.sub_address_no,
      'zip_code': instance.zip_code,
    };
