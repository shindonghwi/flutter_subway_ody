import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/app/env/Environment.dart';
import 'package:subway_ody/presentation/components/ad/KakaoAdFitBannerHelper.dart';

class KakaoAdFitBanner extends HookWidget {
  const KakaoAdFitBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        KakaoAdFitBannerHelper.initNativeAd(
          AdRequestType.initialize,
          Environment.kakaoAdFitId,
          Platform.isAndroid,
          (message) {
            debugPrint(message);
          },
        );
      });
    }, []);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        color: const Color(0xFFF5F5F5),
        child: AspectRatio(
          aspectRatio: 1.43 / 1.00,
          child: Platform.isAndroid
              ? PlatformViewLink(
                  viewType: KakaoAdFitBannerHelper.PLUGIN_VIEW_TYPE,
                  surfaceFactory: (context, controller) {
                    return AndroidViewSurface(
                      controller: controller as AndroidViewController,
                      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                      hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                    );
                  },
                  onCreatePlatformView: (params) {
                    return PlatformViewsService.initSurfaceAndroidView(
                      id: params.id,
                      viewType: KakaoAdFitBannerHelper.PLUGIN_VIEW_TYPE,
                      layoutDirection: TextDirection.ltr,
                      // creationParams: creationParams,
                      creationParamsCodec: const StandardMessageCodec(),
                      onFocus: () {
                        params.onFocusChanged(true);
                      },
                    )
                      ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
                      ..create();
                  },
                )
              : const UiKitView(
                  viewType: KakaoAdFitBannerHelper.PLUGIN_VIEW_TYPE,
                  layoutDirection: TextDirection.ltr,
                  creationParamsCodec: StandardMessageCodec(),
                ),
        ),
      ),
    );
  }
}
