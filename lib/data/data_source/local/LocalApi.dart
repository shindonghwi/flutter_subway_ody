import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subway_ody/data/data_source/local/SharedKey.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/presentation/feature/setting/models/LanguageType.dart';
import 'package:subway_ody/presentation/utils/CollectionUtil.dart';

class LocalApi {
  LocalApi();

  final String autoRefreshCallKey = SharedKeyHelper.fromString(SharedKey.AUTO_REFRESH_CALL);
  final String distanceKey = SharedKeyHelper.fromString(SharedKey.DISTANCE);
  final String languageKey = SharedKeyHelper.fromString(SharedKey.LANGUAGE);
  final String appModeKey = SharedKeyHelper.fromString(SharedKey.APP_MODE);
  final String demoUserLatLngKey = SharedKeyHelper.fromString(SharedKey.DEMO_USER_LATLNG);

  /// 위치 권한 요청
  Future<bool> getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return false;
      }
      return true;
    } else {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }

      return true;
    }
  }

  /// 현재 위치 정보 반환
  Future<LatLng> getLatLng() async {
    Position position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  /// 자동 새로고침 여부 저장
  Future<bool> saveAutoRefreshCall(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    final isComplete = await prefs.setBool(autoRefreshCallKey, isEnabled).then((value) {
      debugPrint("LocalApi - saveAutoRefreshCall : $value");
      return value;
    }).onError((error, stackTrace) {
      return false;
    });
    return isComplete;
  }

  /// 자동 새로고침 여부 반환
  Future<bool> getAutoRefreshCall() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getBool(autoRefreshCallKey) ?? false;
    debugPrint("LocalApi - getAutoRefreshCall : $mode");
    return mode;
  }

  /// 사용자가 설정한 거리 저장
  Future<bool> saveUserDistance(int distance) async {
    final prefs = await SharedPreferences.getInstance();
    final isComplete = await prefs.setInt(distanceKey, distance).then((value) {
      debugPrint("LocalApi - saveDistance : $value");
      return value;
    }).onError((error, stackTrace) {
      return false;
    });
    return isComplete;
  }

  /// 사용자가 설정한 거리 반환
  Future<int?> getUserDistance() async {
    final prefs = await SharedPreferences.getInstance();
    final distance = prefs.getInt(distanceKey);
    debugPrint("LocalApi - getUserDistance : $distance");
    return distance;
  }

  /// 사용자가 설정한 Locale 반환
  Future<Locale> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString(languageKey);
    debugPrint("LocalApi - getLanguage : $language");
    return Locale(language ?? "ko");
  }

  /// 사용자가 설정한 언어 저장
  Future<bool> saveUserLanguage(LanguageType type) async {
    String language = "ko";
    if (type == LanguageType.KOR) {
      language = "ko";
    } else if (type == LanguageType.ENG) {
      language = "en";
    } else if (type == LanguageType.JPN) {
      language = "ja";
    } else if (type == LanguageType.CHN) {
      language = "zh";
    }

    final prefs = await SharedPreferences.getInstance();
    final isComplete = await prefs.setString(languageKey, language).then((value) {
      debugPrint("LocalApi - saveUserLanguage : $value");
      return value;
    }).onError((error, stackTrace) {
      return false;
    });
    return isComplete;
  }

  /// 앱 모드 변경
  Future<bool> changeAppMode(bool isDemo) async {
    final prefs = await SharedPreferences.getInstance();
    final isComplete = await prefs.setBool(appModeKey, false).then((value) {
      debugPrint("LocalApi - changeAppMode : $value");
      return value;
    }).onError((error, stackTrace) {
      return false;
    });
    return isComplete;
  }

  /// 앱 모드 반환
  Future<bool?> getAppMode() async {
    final prefs = await SharedPreferences.getInstance();
    final appMode = prefs.getBool(appModeKey);
    debugPrint("LocalApi - getAppMode : $appMode");
    return appMode;
  }

  /// 데모 모드에서 사용자의 위치 저장
  Future<bool> saveDemoUserLatLng(LatLng latLng) async {
    final prefs = await SharedPreferences.getInstance();
    final isComplete = await prefs.setStringList(demoUserLatLngKey, [
      latLng.latitude.toString(),
      latLng.longitude.toString(),
    ]).then((value) {
      debugPrint("LocalApi - saveDemoUserLatLng : $value");
      return value;
    }).onError((error, stackTrace) {
      return false;
    });
    return isComplete;
  }

  /// 데모 모드에서 사용자의 위치 반환
  Future<LatLng?> getDemoUserLatLng() async {
    final prefs = await SharedPreferences.getInstance();
    final latLngList = prefs.getStringList(demoUserLatLngKey);
    debugPrint("LocalApi - getDemoUserLatLng : $latLngList");

    if (CollectionUtil.isNullorEmpty(latLngList)) {
      return null;
    } else {
      return LatLng(double.tryParse(latLngList!.first), double.tryParse(latLngList.last));
    }
  }
}
