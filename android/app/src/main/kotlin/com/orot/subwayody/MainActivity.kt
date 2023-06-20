package com.orot.subwayody

import com.orot.subwayody.ad.kakao.AdFitBannerViewFactory
import com.orot.subwayody.ad.kakao.AdFitNativeViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(
                "plugin/kakao_adfit_native",
                AdFitNativeViewFactory(flutterEngine.dartExecutor.binaryMessenger)
            )

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(
                "plugin/kakao_adfit_banner",
                AdFitBannerViewFactory(flutterEngine.dartExecutor.binaryMessenger)
            )


    }

}
