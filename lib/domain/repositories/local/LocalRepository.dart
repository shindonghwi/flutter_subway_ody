import 'package:flutter/material.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/presentation/feature/setting/models/LanguageType.dart';

abstract class LocalRepository {
  Future<bool> getLocationPermission(); // location 권한 요청

  Future<bool> saveAutoRefreshCall(bool isEnabled); // 자동 새로고침 여부 저장

  Future<bool> getAutoRefreshCall(); // 자동 새로고침 여부

  Future<LatLng> getLatLng(); // 현재 위치의 위도, 경도 반환

  Future<bool> saveUserDistance(int distance); // 사용자가 설정한 거리 저장

  Future<int?> getUserDistance(); // 사용자가 설정한 거리 반환

  Future<bool> saveUserLanguage(LanguageType type); // 사용자가 설정한 언어 저장

  Future<Locale> getUserLanguage(); // 사용자가 설정한 언어 반환

  Future<bool> changeAppMode(bool isDemo); // 앱 모드 변경

  Future<bool> getAppDemoMode(); // 앱 모드 반환

  Future<bool> saveDemoUserLatLng(LatLng latLng); // 데모 모드에서 사용자의 위치 저장

  Future<LatLng?> getDemoUserLatLng(); // 데모 모드에서 사용자의 위치 반환

  Future<bool> patchIntroPopUpShowing(bool state); // 초기 팝업 노출 여부 수정

  Future<bool> getIntroPopUpShowing(); // 초기 팝업 노출 여부 반환
}
