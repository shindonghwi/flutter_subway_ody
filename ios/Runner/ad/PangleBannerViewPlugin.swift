import Flutter
import UIKit

class PangleBannerViewPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let nativeViewFactory = PangleBannerViewFactory(messenger: registrar.messenger())
        registrar.register(nativeViewFactory, withId: "plugin/pangle_banner")
    }
}
