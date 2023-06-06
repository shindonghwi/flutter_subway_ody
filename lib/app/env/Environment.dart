import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/di/locator.dart';

enum BuildType { dev, prod }

class Environment {
  const Environment._internal(this._buildType);

  final BuildType _buildType;
  static Environment _instance = const Environment._internal(BuildType.dev);

  static Environment get instance => _instance;

  static BuildType get buildType => _instance._buildType;

  static String get apiUrl => _instance._buildType == BuildType.dev ? '' : ''; // api 주소

  static String get apiVersion =>
      _instance._buildType == BuildType.dev ? 'v1' : 'v1'; // api Version

  factory Environment.newInstance(BuildType buildType) {
    _instance = Environment._internal(buildType);
    return _instance;
  }

  bool get isDebuggable => _buildType == BuildType.dev;

  static String get kakaoRestApiKey => _instance._buildType == BuildType.dev
      ? '06de5b28e76880404c369fcb6a81c230' // dev
      // ? 'f530105b5b52ed538b03582ee0a54f11' // dev
      : '9672018471d87420b9bc260308a8bc9c';

  void run() async {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    initServiceLocator();

    runApp(const ProviderScope(child: SubwayOdyApp()));
  }
}
