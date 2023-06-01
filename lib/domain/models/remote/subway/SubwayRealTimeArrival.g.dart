// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubwayRealTimeArrival.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubwayRealTimeArrival _$SubwayRealTimeArrivalFromJson(
        Map<String, dynamic> json) =>
    SubwayRealTimeArrival(
      subwayId: json['subwayId'] as String,
      updnLine: json['updnLine'] as String,
      trainLineNm: json['trainLineNm'] as String,
      statnNm: json['statnNm'] as String,
      btrainSttus: json['btrainSttus'] as String,
      arvlMsg2: json['arvlMsg2'] as String,
    );

Map<String, dynamic> _$SubwayRealTimeArrivalToJson(
        SubwayRealTimeArrival instance) =>
    <String, dynamic>{
      'subwayId': instance.subwayId,
      'updnLine': instance.updnLine,
      'trainLineNm': instance.trainLineNm,
      'statnNm': instance.statnNm,
      'btrainSttus': instance.btrainSttus,
      'arvlMsg2': instance.arvlMsg2,
    };
