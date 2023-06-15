import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subway_ody/data/data_source/local/SharedKey.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/presentation/feature/setting/models/LanguageType.dart';

class LocalApi {
  LocalApi();

  final String autoRefreshCallKey = SharedKeyHelper.fromString(SharedKey.AUTO_REFRESH_CALL);
  final String distanceKey = SharedKeyHelper.fromString(SharedKey.DISTANCE);
  final String languageKey = SharedKeyHelper.fromString(SharedKey.LANGUAGE);

  /// 위치 권한 요청
  Future<bool> getLocationPermission() async {
    Location location = Location();

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.granted) {
      return true;
    } else {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return false;
        }
      }

      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }

      return true;
    }
  }

  /// 현재 위치 정보 반환
  Future<LatLng> getLatLng() async {
    Location location = Location();

    return await location
        .getLocation()
        .then(
          (value) => LatLng(
            value.latitude,
            value.longitude,
          ),
        )
        .onError((error, stackTrace) {
      debugPrint("getLatLng error: $error");
      return Future(() => LatLng(0, 0));
    });
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
}
