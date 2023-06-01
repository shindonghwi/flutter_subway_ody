import 'package:subway_ody/domain/models/local/LatLng.dart';

abstract class LocalRepository {
  Future<bool> getLocationPermission(); // location 권한 요청

  Future<bool> saveAutoRefreshCall(bool isEnabled); // 자동 새로고침 여부 저장

  Future<bool> getAutoRefreshCall(); // 자동 새로고침 여부

  Future<LatLng> getLatLng(); // 현재 위치의 위도, 경도 반환

  Future<bool> saveUserDistance(int distance); // 사용자가 설정한 거리 저장

  Future<int> getUserDistance(); // 사용자가 설정한 거리 반환
}
