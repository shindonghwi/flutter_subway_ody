import 'package:flutter/material.dart';
import 'package:subway_ody/presentation/utils/dto/Pair.dart';

class SubwayPositionModel {
  final String subwayName;
  final String arvlMsg3;
  final String arvlCd;
  final String ordkey;

  SubwayPositionModel({
    required this.subwayName,
    required this.arvlMsg3,
    required this.arvlCd,
    required this.ordkey,
  });
}


class SubwayModel {
  final String subwayId; // 홍대입구
  final String subwayName; // 홍대입구
  final String subwayLine; // 1호선
  final String distance; // 거리
  final Color mainColor; // 지하철 컬러

  List<SubwayDirectionStationModel> stations; // 상행/내선 정보

  SubwayModel({
    required this.subwayId,
    required this.subwayName,
    required this.subwayLine,
    required this.distance,
    required this.mainColor,
    required this.stations,
  });
}


class SubwayDirectionStationModel {
  final List<String> nameList;

  /// subtitle 영역 ex) 내선순환(합정방향) 3분뒤 도착
  final String updnLine;
  final String ordkey;
  final String destination; // 인천행
  final String nextStation; // 가좌방면
  final String arvlMsg2; // 3분뒤 도착
  final String arvlMsg3; // 현재 위치
  final String btrainSttus; // 급행 여부

  final List<Pair<int,SubwayPositionModel?>> subwayPositionList; // 지하철 위치 정보


  SubwayDirectionStationModel({
    required this.nameList, // 현재역에서 realtimeSubwayInfo 기준으로 5개 찾아야함.
    required this.destination,
    required this.nextStation,
    required this.btrainSttus,
    required this.arvlMsg2,
    required this.arvlMsg3,
    required this.subwayPositionList,
    required this.updnLine,
    required this.ordkey,
  });
}