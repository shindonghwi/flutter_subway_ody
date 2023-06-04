import 'package:flutter/material.dart';

class SubwayModel {
  final String subwayName; // 홍대입구
  final String subwayLine; // 1호선
  final String distance; // 거리
  final Color mainColor; // 지하철 컬러

  final List<SubwayDirectionStationModel> stationInfoList; // 상행/내선 정보

  SubwayModel({
    required this.subwayName,
    required this.subwayLine,
    required this.distance,
    required this.mainColor,
    required this.stationInfoList,
  });
}

class SubwayDirectionStationModel {
  final List<String> subwayNameList;

  /// subtitle 영역 ex) 내선순환(합정방향) 3분뒤 도착
  final String destination; // 인천행
  final String nextStation; // 가좌방면
  final String arvlMsg2; // 3분뒤 도착

  final List<int> subwayPositionList; // 지하철 위치 정보

  final String updnLine;
  final String arvlMsg3;
  final String arvlCd;
  final String ordkey;

  SubwayDirectionStationModel({
    required this.subwayNameList, // 현재역에서 realtimeSubwayInfo 기준으로 5개 찾아야함.
    required this.destination,
    required this.nextStation,
    required this.arvlMsg2,
    required this.subwayPositionList,
    required this.updnLine,
    required this.arvlMsg3,
    required this.arvlCd,
    required this.ordkey,
  });
}
