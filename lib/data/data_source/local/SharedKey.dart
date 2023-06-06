enum SharedKey {
  AUTO_REFRESH_CALL, // 자동 새로고침 여부
  DISTANCE, // 사용자가 설정한 거리
  LANGUAGE, // 사용자가 설정한 언어
}

class SharedKeyHelper {
  static const Map<SharedKey, String> _stringToEnum = {
    SharedKey.AUTO_REFRESH_CALL: "AUTO_REFRESH_CALL",
    SharedKey.DISTANCE: "DISTANCE",
    SharedKey.LANGUAGE: "LANGUAGE",
  };

  static String fromString(SharedKey key) => _stringToEnum[key]!;

}
