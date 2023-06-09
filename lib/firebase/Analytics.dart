import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:subway_ody/app/env/Environment.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/presentation/feature/setting/models/LanguageType.dart';
import 'package:subway_ody/presentation/navigation/Route.dart';
import 'package:subway_ody/presentation/utils/CollectionUtil.dart';

class Analytics {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static FirebaseAnalytics instance() => Analytics().analytics;

  static void eventAppOpened() async {
    if (Environment.buildType == BuildType.prod) instance().logAppOpen();
  }

  static void eventScreenRecord(String route) async {
    if (Environment.buildType == BuildType.prod) instance().setCurrentScreen(screenName: route.route);
  }

  /// 거리 설정
  static void eventSetDistance(int distance) async {
    try{
      if (Environment.buildType == BuildType.prod) {
        instance().logEvent(
          name: "user-set-distance",
          parameters: {
            "value": distance,
          },
        );
      }
    }catch(e){
      instance().logEvent(
        name: "error",
        parameters: {
          "type": "user-set-distance",
          "value": distance,
          "error": e.toString(),
        },
      );
    }
  }

  /// 언어 설정
  static void eventSetLanguage(LanguageType type) async {
    try{
      if (Environment.buildType == BuildType.prod) {
        instance().logEvent(
          name: "user-set-language",
          parameters: {
            "value": type,
          },
        );
      }
    }catch(e){
      instance().logEvent(
        name: "error",
        parameters: {
          "type": "user-set-language",
          "value": type,
          "error": e.toString(),
        },
      );
    }
  }

  /// 사용자 위 경도 저장
  static void eventSetUserLatLng(LatLng latLng) async {
    try{
      if (Environment.buildType == BuildType.prod) {
        instance().logEvent(
          name: "user-set-latlng",
          parameters: {
            "latitude": latLng.latitude,
            "longitude": latLng.longitude,
          },
        );
      }
    }catch(e){
      instance().logEvent(
        name: "error",
        parameters: {
          "type": "user-set-latlng",
          "value": {
            "latitude": latLng.latitude,
            "longitude": latLng.longitude,
          },
          "error": e.toString(),
        },
      );
    }
  }

  /// 지하철역 이름 저장
  static void eventFavoriteSubwayName(String subwayName) async {
    try{
      if (Environment.buildType == BuildType.prod) {
        instance().logEvent(
          name: "favorite-subway-name",
          parameters: {
            "value": subwayName,
          },
        );
      }
    }catch(e){
      instance().logEvent(
        name: "error",
        parameters: {
          "type": "favorite-subway-name",
          "value": subwayName,
          "error": e.toString(),
        },
      );
    }
  }

  /// 지하철역 호선 저장
  static void eventFavoriteSubwayLine(String subwayLine) async {
    try{
      if (Environment.buildType == BuildType.prod) {
        instance().logEvent(
          name: "favorite-subway-line",
          parameters: {
            "value": subwayLine,
          },
        );
      }
    }catch(e){
      instance().logEvent(
        name: "error",
        parameters: {
          "type": "favorite-subway-line",
          "value": subwayLine,
          "error": e.toString(),
        },
      );
    }
  }

  /// 수동 새로고침
  static void eventManualRefresh() async {
    try{
      if (Environment.buildType == BuildType.prod) {
        instance().logEvent(
          name: "refresh",
          parameters: {
            "value": "manual",
          },
        );
      }
    }catch(e){
      instance().logEvent(
        name: "error",
        parameters: {
          "type": "refresh",
          "value": "manual",
          "error": e.toString(),
        },
      );
    }
  }

  /// 지역저장 8도
  static void eventAddressDo(String? address) async {
    try{
      if (CollectionUtil.isNullEmptyFromString(address)) return;
      if (Environment.buildType == BuildType.prod) {
        instance().logEvent(
          name: "address",
          parameters: {
            "do": address,
          },
        );
      }
    }catch(e){
      instance().logEvent(
        name: "error",
        parameters: {
          "type": "address",
          "value": address,
          "error": e.toString(),
        },
      );
    }
  }

  /// 지역저장 동
  static void eventAddressGu(String? address) async {
    try{
      if (CollectionUtil.isNullEmptyFromString(address)) return;
      if (Environment.buildType == BuildType.prod) {
        instance().logEvent(
          name: "address",
          parameters: {
            "gu": address,
          },
        );
      }
    }catch(e){
      instance().logEvent(
        name: "error",
        parameters: {
          "type": "address",
          "value": address,
          "error": e.toString(),
        },
      );
    }
  }

  /// 지역저장 구
  static void eventAddressDong(String? address) async {
    try{
      if (CollectionUtil.isNullEmptyFromString(address)) return;
      if (Environment.buildType == BuildType.prod) {
        instance().logEvent(
          name: "address",
          parameters: {
            "dong": address,
          },
        );
      }
    }catch(e){
      instance().logEvent(
        name: "error",
        parameters: {
          "type": "address",
          "value": address,
          "error": e.toString(),
        },
      );
    }
  }
}
