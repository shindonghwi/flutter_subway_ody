package com.orot.subwayody.ad.pangle

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import com.bytedance.sdk.openadsdk.api.banner.PAGBannerAd
import com.bytedance.sdk.openadsdk.api.banner.PAGBannerSize
import com.orot.subwayody.R
import com.orot.subwayody.ad.AdvertiseListener
import com.orot.subwayody.ad.BaseView
import com.orot.subwayody.ad.channelPangleBanner
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.platform.PlatformView

class PangleBannerView(
    private val context: Context,
    private val binaryMessenger: BinaryMessenger,
) : PlatformView, BaseView(context) {

    override fun getView(): ViewGroup = rootLayout
    override fun dispose() {}

    override val eventChannel: String get() = channelPangleBanner

    lateinit var channel: EventChannel
    private var eventSink: EventChannel.EventSink? = null

    init {
        createChannel()
        PangleHelper.run {
            initialize(context)
            loadBannerAd(
                "980569516", getBannerRequest(PAGBannerSize.BANNER_W_320_H_50),
                advertiseListener = object : AdvertiseListener<PAGBannerAd?> {
                    override fun onAdLoaded(ad: PAGBannerAd?) {
//                        Toast.makeText(context, "onAdLoaded", Toast.LENGTH_SHORT).show()
                        applyBindingViewH50(ad?.bannerView)
                        eventSink?.success("onAdLoaded")
                    }

                    override fun onAdFailed(msg: String) {
//                        Toast.makeText(context, "onAdFailed : $msg", Toast.LENGTH_SHORT).show()
                        eventSink?.success("onAdFailed")
                    }

                    override fun onAdClick() {
//                        Toast.makeText(context, "onAdClick", Toast.LENGTH_SHORT).show()
                        eventSink?.success("onAdClick")
                    }

                    override fun onAdShow() {
//                        Toast.makeText(context, "onAdShow", Toast.LENGTH_SHORT).show()
                        eventSink?.success("onAdShow")
                    }

                    override fun onAdDismiss() {
//                        Toast.makeText(context, "onAdDismiss", Toast.LENGTH_SHORT).show()
                        eventSink?.success("onAdDismiss")
                    }
                }
            )
        }
    }

    /** Flutter 측에서 Native 코드와 통신할 채널 */
    private fun createChannel() {
        channel = EventChannel(
            binaryMessenger,
            eventChannel
        ).apply {
            setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                }
            })
        }
    }
}