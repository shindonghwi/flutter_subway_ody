// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubwayResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubwayResponse _$SubwayResponseFromJson(Map<String, dynamic> json) =>
    SubwayResponse(
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
      'errorMessage': instance.errorMessage,
      'realtimeArrivalList': instance.realtimeArrivalList,
    };
