enum SharedKey {
  AUTO_REFRESH_CALL, // 자동 새로고침 여부
  DISTANCE, // 사용자가 설정한 거리
}

class SharedKeyHelper {
  static const Map<SharedKey, String> _stringToEnum = {
    SharedKey.AUTO_REFRESH_CALL: "AUTO_REFRESH_CALL",
    SharedKey.DISTANCE: "DISTANCE",
  };

  static String fromString(SharedKey key) => _stringToEnum[key]!;

}
