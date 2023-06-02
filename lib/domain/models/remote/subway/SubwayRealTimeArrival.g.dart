// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubwayRealTimeArrival.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubwayRealTimeArrival _$SubwayRealTimeArrivalFromJson(
        Map<String, dynamic> json) =>
    SubwayRealTimeArrival(
      subwayId: json['subwayId'] as String,
      statnId: json['statnId'] as String,
      statnFid: json['statnFid'] as String,
      statnTid: json['statnTid'] as String,
      ordkey: json['ordkey'] as String,
      updnLine: json['updnLine'] as String,
      trainLineNm: json['trainLineNm'] as String,
      statnNm: json['statnNm'] as String,
      btrainSttus: json['btrainSttus'] as String,
      arvlMsg2: json['arvlMsg2'] as String,
      arvlMsg3: json['arvlMsg3'] as String,
      arvlCd: json['arvlCd'] as String,
    );

Map<String, dynamic> _$SubwayRealTimeArrivalToJson(
        SubwayRealTimeArrival instance) =>
    <String, dynamic>{
      'subwayId': instance.subwayId,
      'statnId': instance.statnId,
      'statnFid': instance.statnFid,
      'statnTid': instance.statnTid,
      'ordkey': instance.ordkey,
      'updnLine': instance.updnLine,
      'trainLineNm': instance.trainLineNm,
      'statnNm': instance.statnNm,
      'btrainSttus': instance.btrainSttus,
      'arvlMsg2': instance.arvlMsg2,
      'arvlMsg3': instance.arvlMsg3,
      'arvlCd': instance.arvlCd,
    };
