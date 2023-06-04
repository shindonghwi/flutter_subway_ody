import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subway_ody/data/data_source/local/SharedKey.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';

class LocalApi {
  LocalApi();

  final String autoRefreshCallKey = SharedKeyHelper.fromString(SharedKey.AUTO_REFRESH_CALL);
  final String distanceKey = SharedKeyHelper.fromString(SharedKey.DISTANCE);

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
    return await location.getLocation().then(
          (value) => LatLng(
            value.latitude,
            value.longitude,
          ),
        );
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
  Future<int> getUserDistance() async {
    final prefs = await SharedPreferences.getInstance();
    final distance = prefs.getInt(distanceKey) ?? 800;
    debugPrint("LocalApi - getUserDistance : $distance");
    return distance;
  }


}
