import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

enum AdRequestType {
  initialize,
}

class KakaoAdFitBannerHelper {
  static const String PLUGIN_VIEW_TYPE = "plugin/kakao_adfit";
  static const String CHANNEL_NAME = "ad.kakao_adfit_channel";

  static const _platform = BasicMessageChannel(CHANNEL_NAME, StringCodec());

  static void initAd(
    AdRequestType type,
    String adId,
    bool isAndroid,
    Function(String) onMessageReceived,
  ) async {
    Future.delayed(const Duration(seconds: 1), () async {
      debugPrint("KakaoAdFitBannerHelper type: $type adId: $adId isAndroid: $isAndroid");

      final response = await _platform.send(
        jsonEncode({"type": type.name, "adId": adId, "isAndroid": isAndroid}),
      );
      onMessageReceived.call("Received: ${response.toString()}");
    });

  }
}
