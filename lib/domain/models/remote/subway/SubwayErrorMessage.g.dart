// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubwayErrorMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubwayErrorMessage _$SubwayErrorMessageFromJson(Map<String, dynamic> json) =>
    SubwayErrorMessage(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      link: json['link'] as String,
      developerMessage: json['developerMessage'] as String,
      total: json['total'] as int,
    );

Map<String, dynamic> _$SubwayErrorMessageToJson(SubwayErrorMessage instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'link': instance.link,
      'developerMessage': instance.developerMessage,
      'total': instance.total,
    };
