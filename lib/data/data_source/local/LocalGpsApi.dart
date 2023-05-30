import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subway_ody/data/data_source/local/SharedKey.dart';

class LocalGpsApi {
  LocalGpsApi();

  final String autoRefreshCallKey =
      SharedKeyHelper.fromString(SharedKey.AUTO_REFRESH_CALL);

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

  /// 자동 새로고침 여부 저장
  Future<bool> saveAutoRefreshCall(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    final isComplete = await prefs.setBool(autoRefreshCallKey, isEnabled).then((value) {
      debugPrint("LocalGpsApi - saveAutoRefreshCall : $value");
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
    debugPrint("LocalGpsApi - getAutoRefreshCall : $mode");
    return mode;
  }
}
