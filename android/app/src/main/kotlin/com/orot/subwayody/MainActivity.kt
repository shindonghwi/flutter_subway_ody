package com.orot.subwayody

import com.orot.subwayody.ad.pangle.PangleBannerViewFactory
import com.orot.subwayody.ad.pluginPangleBanner
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
                pluginPangleBanner,
                PangleBannerViewFactory(flutterEngine.dartExecutor.binaryMessenger)
            )


    }

}
