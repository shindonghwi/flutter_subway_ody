import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/di/locator.dart';
import 'package:subway_ody/presentation/components/ad/AdvertiseHelper.dart';
import 'package:subway_ody/presentation/utils/RestartWidget.dart';

enum BuildType { dev, prod }

class Environment {
  const Environment._internal(this._buildType);

  final BuildType _buildType;
  static Environment _instance = const Environment._internal(BuildType.dev);

  static Environment get instance => _instance;

  static BuildType get buildType => _instance._buildType;

  static String get apiUrl => _instance._buildType == BuildType.dev ? '' : ''; // api 주소

  static String get apiVersion => _instance._buildType == BuildType.dev ? 'v1' : 'v1'; // api Version

  factory Environment.newInstance(BuildType buildType) {
    _instance = Environment._internal(buildType);
    return _instance;
  }

  bool get isDebuggable => _buildType == BuildType.dev;

  static String get kakaoRestApiKey => '9672018471d87420b9bc260308a8bc9c';

  static String get naverClientId => 'rtujewrui1';

  void run() async {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    if (Platform.isIOS) {
      if (await AppTrackingTransparency.trackingAuthorizationStatus == TrackingStatus.notDetermined) {
        // Wait for dialog popping animation
        await Future.delayed(const Duration(milliseconds: 200));
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    }

    await NaverMapSdk.instance.initialize(clientId: Environment.naverClientId);
    AdvertiseHelper.initAdMob();
    initServiceLocator();

    runApp(const RestartWidget(child: ProviderScope(child: SubwayOdyApp())));
  }
}


