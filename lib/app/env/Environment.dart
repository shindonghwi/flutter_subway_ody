import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/di/locator.dart';
import 'package:subway_ody/firebase/Analytics.dart';
import 'package:subway_ody/firebase_options.dart';
import 'package:subway_ody/presentation/utils/RestartWidget.dart';

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

  static String get kakaoAdFitId =>
      Platform.isAndroid ? 'DAN-smkKi8A2hYTvXIQ9' : '';

  static String get kakaoRestApiKey => '9672018471d87420b9bc260308a8bc9c';

  void run() async {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    initServiceLocator();

    runApp(const RestartWidget(child: ProviderScope(child: SubwayOdyApp())));
  }
}
