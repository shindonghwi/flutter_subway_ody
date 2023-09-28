import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
//      setupPangleSDK()
//      weak var nativeRegistrar = self.registrar(forPlugin: "PangleBannerViewPlugin")

//      let nativeFactory = PangleBannerViewFactory(messenger: nativeRegistrar!.messenger())
//      self.registrar(forPlugin: "<PangleBannerViewPlugin>")!.register(
//          nativeFactory,
//      withId: "plugin/pangle_banner")
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
//    func setupPangleSDK() {
//        let config = PAGConfig.share()
//        config.appID = "8147567"
//        config.appLogoImage = UIImage(named: "AppIcon")
//        #if DEBUG
//        config.debugLog = true
//        #endif
//        PAGSdk.start(with: config) { success, error in
//            if success {
//                print("@@@@@ Success")
//                // load ad data
//            }else{
//                print("@@@@@ ERROR")
//
//            }
//        }
//    }

    
}
