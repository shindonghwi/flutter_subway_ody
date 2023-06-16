enum SharedKey {
  AUTO_REFRESH_CALL, // 자동 새로고침 여부
  DISTANCE, // 사용자가 설정한 거리
  LANGUAGE, // 사용자가 설정한 언어
  APP_MODE, // 앱 모드 ( 데모, 실제 )
}

class SharedKeyHelper {
  static const Map<SharedKey, String> _stringToEnum = {
    SharedKey.AUTO_REFRESH_CALL: "AUTO_REFRESH_CALL",
    SharedKey.DISTANCE: "DISTANCE",
    SharedKey.LANGUAGE: "LANGUAGE",
    SharedKey.APP_MODE: "APP_MODE",
  };

  static String fromString(SharedKey key) => _stringToEnum[key]!;

}
