import 'package:json_annotation/json_annotation.dart';

part 'SubwayRealTimeArrival.g.dart';

@JsonSerializable()
class SubwayRealTimeArrival {

  /// 1001:1호선 1002:2호선 1003:3호선, 1004:4호선,1005:5호선, 1006:6호선,1007:7호선, 1008:8호선, 1009:9호선,
  /// 1061:중앙선 1063:경의중앙선, 1065:공항철도, 1067:경춘선, 1075:수의분당선 1077:신분당선, 1092:우이신설선
  final String subwayId; //

  final String updnLine; // 0: 상행/내선, 1: 하행/외선
  final String trainLineNm; // 성수행(목적지역) - 구로디지털단지방면(다음역)
  final String statnNm; // 지하철 역 명 (예: 홍대입구)
  final String btrainSttus; // 급행, ITX, 일반
  final String arvlMsg2; // 첫번째 도착 메새지


  SubwayRealTimeArrival({
    required this.subwayId,
    required this.updnLine,
    required this.trainLineNm,
    required this.statnNm,
    required this.btrainSttus,
    required this.arvlMsg2,
  });

  factory SubwayRealTimeArrival.fromJson(Map<String, dynamic> json) => _$SubwayRealTimeArrivalFromJson(json);

  Map<String, dynamic> toJson() => _$SubwayRealTimeArrivalToJson(this);

}


