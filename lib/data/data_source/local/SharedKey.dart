enum SharedKey {
  AUTO_REFRESH_CALL, // 자동 새로고침 여부
  DISTANCE, // 사용자가 설정한 거리
  LANGUAGE, // 사용자가 설정한 언어
  APP_MODE, // 앱 모드 ( 데모, 실제 )
  DEMO_USER_LATLNG, // 데모모드에서 사용자의 위치
  INTRO_SHOWING, // 앱 시작시 팝업 노출 여부
}

class SharedKeyHelper {
  static const Map<SharedKey, String> _stringToEnum = {
    SharedKey.AUTO_REFRESH_CALL: "AUTO_REFRESH_CALL",
    SharedKey.DISTANCE: "DISTANCE",
    SharedKey.LANGUAGE: "LANGUAGE",
    SharedKey.APP_MODE: "APP_MODE",
    SharedKey.DEMO_USER_LATLNG: "DEMO_USER_LATLNG",
    SharedKey.INTRO_SHOWING: "INTRO_SHOWING",
  };

  static String fromString(SharedKey key) => _stringToEnum[key]!;

}
