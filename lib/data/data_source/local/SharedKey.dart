enum SharedKey {
  APP_USE_POLICY, // 앱 사용 약관 동의
  SOCIAL_ACCESS_TOKEN, // 소셜 토큰
}

class SharedKeyHelper {
  static const Map<SharedKey, String> _stringToEnum = {
    SharedKey.APP_USE_POLICY: "APP_USE_POLICY",
    SharedKey.SOCIAL_ACCESS_TOKEN: "SOCIAL_ACCESS_TOKEN",
  };

  static String fromString(SharedKey key) => _stringToEnum[key]!;

}
