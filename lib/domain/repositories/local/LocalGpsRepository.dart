abstract class LocalGpsRepository {
  Future<bool> getLocationPermission(); // location 권한 요청

  Future<bool> saveAutoRefreshCall(bool isEnabled); // 자동 새로고침 여부 저장

  Future<bool> getAutoRefreshCall(); // 자동 새로고침 여부
}
