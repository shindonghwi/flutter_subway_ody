class BaseIntent {
  String errorMessage = "";

  BaseIntent({
    errorMessage,
  });
}

class MainIntent{
  final String region;

  MainIntent({
    required this.region,
  });
}
