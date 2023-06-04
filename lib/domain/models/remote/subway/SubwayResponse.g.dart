// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubwayResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubwayResponse _$SubwayResponseFromJson(Map<String, dynamic> json) =>
    SubwayResponse(
      status: json['status'] as int?,
      code: json['code'] as String?,
      message: json['message'] as String?,
      link: json['link'] as String?,
      developerMessage: json['developerMessage'] as String?,
      total: json['total'] as int?,
      errorMessage: json['errorMessage'] == null
          ? null
          : SubwayErrorMessage.fromJson(
              json['errorMessage'] as Map<String, dynamic>),
      realtimeArrivalList: (json['realtimeArrivalList'] as List<dynamic>?)
          ?.map(
              (e) => SubwayRealTimeArrival.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubwayResponseToJson(SubwayResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'link': instance.link,
      'developerMessage': instance.developerMessage,
      'total': instance.total,
      'errorMessage': instance.errorMessage,
      'realtimeArrivalList': instance.realtimeArrivalList,
    };
