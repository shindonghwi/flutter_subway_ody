import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:subway_ody/app/env/Environment.dart';

class AdvertiseHelper {

  // /// Pangle AD
  // static const String PLUGIN_PANGLE_BANNER = "plugin/pangle_banner";
  // static const String CHANNEL_PANGLE_BANNER = "channel/pangle_banner";
  //
  // static void initPangleBannerAd({
  //   required Function() onAdLoaded,
  //   required Function() onAdError,
  //   required Function() onAdDismiss,
  //   required Function() onAdShow,
  //   required Function() onAdClick,
  // }) async {
  //   const _platform = EventChannel(CHANNEL_PANGLE_BANNER);
  //
  //   Future.delayed(const Duration(seconds: 1), () async {
  //     _platform.receiveBroadcastStream().listen((event) {
  //       debugPrint("initPangleBannerAd event: ${event.toString()}");
  //       switch (event) {
  //         case "onAdLoaded":
  //           onAdLoaded();
  //           break;
  //         case "onAdError":
  //           onAdError();
  //           break;
  //         case "onAdDismiss":
  //           onAdDismiss();
  //           break;
  //         case "onAdShow":
  //           onAdShow();
  //           break;
  //         case "onAdClick":
  //           onAdClick();
  //           break;
  //       }
  //     });
  //   });
  // }


  /// Ad Mob - 배너광고
  static String admobBannerId = Platform.isAndroid
      ? Environment.buildType == BuildType.dev
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3488970363462155/2301086782'
      : Environment.buildType == BuildType.dev
          ? 'ca-app-pub-3940256099942544/2934735716'
          : 'ca-app-pub-3488970363462155/3903211986';

  /// Ad Mob - FullScreen - 앱 종료시
  static String admobFullBannerId = Platform.isAndroid
      ? Environment.buildType == BuildType.dev
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3488970363462155/6822261979'
      : Environment.buildType == BuildType.dev
          ? 'ca-app-pub-3940256099942544/4411468910'
          : 'ca-app-pub-3488970363462155/1186791911';

  static Future<InitializationStatus> initAdMob() {
    return MobileAds.instance.initialize();
  }

}
