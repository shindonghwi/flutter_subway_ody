import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:subway_ody/app/env/Environment.dart';

class Advertisement {
  static String get kakaoAdFitId => Platform.isAndroid ? 'DAN-smkKi8A2hYTvXIQ9' : '';

  static String get admobBannerId => Platform.isAndroid
      ? Environment.buildType == BuildType.dev
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3488970363462155/2301086782'
      : Environment.buildType == BuildType.dev
          ? 'ca-app-pub-3940256099942544/2934735716'
          : '';

  static Future<InitializationStatus> initAdMob() {
    return MobileAds.instance.initialize();
  }
}
