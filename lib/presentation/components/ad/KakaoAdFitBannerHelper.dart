import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

enum AdRequestType {
  initialize,
}

class KakaoAdFitBannerHelper {
  static const String PLUGIN_NATIVE = "plugin/kakao_adfit_native";
  static const String PLUGIN_BANNER = "plugin/kakao_adfit_banner";

  static const String CHANNEL_NATIVE = "ad.kakao_adfit_native_channel";
  static const String CHANNEL_BANNER = "ad.kakao_adfit_banner_channel";

  static void initNativeAd(
    AdRequestType type,
    String adId,
    bool isAndroid,
    Function(String) onMessageReceived,
  ) async {
    const _platform = BasicMessageChannel(CHANNEL_NATIVE, StringCodec());
    Future.delayed(const Duration(seconds: 1), () async {
      debugPrint("KakaoAdFitBannerHelper type: $type adId: $adId isAndroid: $isAndroid");

      final response = await _platform.send(
        jsonEncode({"type": type.name, "adId": adId, "isAndroid": isAndroid}),
      );
      onMessageReceived.call("Received: ${response.toString()}");
    });
  }

  static void initBannerAd(
    AdRequestType type,
    String adId,
    bool isAndroid,
    Function(String) onMessageReceived,
  ) async {
    const _platform = BasicMessageChannel(CHANNEL_BANNER, StringCodec());
    Future.delayed(const Duration(seconds: 1), () async {
      debugPrint("KakaoAdFitBannerHelper type: $type adId: $adId isAndroid: $isAndroid");

      final response = await _platform.send(
        jsonEncode({"type": type.name, "adId": adId, "isAndroid": isAndroid}),
      );
      onMessageReceived.call("Received: ${response.toString()}");
    });
  }



}
