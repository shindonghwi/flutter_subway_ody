import Flutter
import UIKit
import PAGAdSDK


class PangleBannerView: NSObject, FlutterPlatformView, PAGBannerAdDelegate, FlutterStreamHandler {
    private var frame: CGRect
    private var viewIdentifier: Int64
    private var arguments: Any?
    private var binaryMessenger: FlutterBinaryMessenger

    private var bannerAd: PAGBannerAd?
    private var bannerView: UIView
    
    private var eventChannel: FlutterEventChannel?
    private var eventSink: FlutterEventSink?
    
    private var isFirstAdLoaded: Bool = false
    
    init(
        frame: CGRect,
        viewIdentifier: Int64,
        arguments: Any?,
        binaryMessenger: FlutterBinaryMessenger
    ) {
        self.bannerView = UIView()
        self.frame = frame
        self.viewIdentifier = viewIdentifier
        self.arguments = arguments
        self.binaryMessenger = binaryMessenger
        super.init()
        setupEventChannel()
        createPangleBannerView(view: self.bannerView)
    }

    func view() -> UIView {
        bannerView.backgroundColor = UIColor(named: "#FF0000")
        bannerView.frame.size.width = UIScreen.main.bounds.width
        return bannerView
    }

    func setupEventChannel() {
        eventChannel = FlutterEventChannel(name: "channel/pangle_banner", binaryMessenger: binaryMessenger)
        eventChannel?.setStreamHandler(self)
    }
    
    func sendEventToFlutter(eventData: Any) {
        eventSink?(eventData)
    }
    
    func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        if isFirstAdLoaded == false{
            isFirstAdLoaded = true;
            self.sendEventToFlutter(eventData: "onAdLoaded")
        }
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }

    func createPangleBannerView(view _view: UIView){
        PAGBannerAd.load(withSlotID: "980569948", request: PAGBannerRequest(bannerSize: kPAGBannerSize320x50)) { bannerAd, error in
            if let error = error {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.sendEventToFlutter(eventData: "onAdError")
                }
                print("Banner ad load failed: \(error)")
                return
            }
            
            self.bannerAd = bannerAd
            self.bannerAd?.delegate = self
            self.bannerView = self.bannerAd!.bannerView
            
            self.bannerView.frame = CGRect(
                x: (_view.frame.size.width - 320) / 2.0,
                y: _view.frame.size.height - 50,
                width: 320,
                height: 50
            )

            _view.addSubview(self.bannerView)
            
            self.sendEventToFlutter(eventData: "onAdLoaded")
        }
    }
    
    func adDidShow(_ ad: PAGAdProtocol) {
        sendEventToFlutter(eventData: "onAdShow")
    }
    
    func adDidClick(_ ad: PAGAdProtocol) {
        sendEventToFlutter(eventData: "onAdClick")
    }
    func adDidDismiss(_ ad: PAGAdProtocol) {
        sendEventToFlutter(eventData: "onAdDismiss")
    }
    func adDidShowFail(_ ad: PAGAdProtocol, error: Error) {
        sendEventToFlutter(eventData: "onAdError")
    }
}
