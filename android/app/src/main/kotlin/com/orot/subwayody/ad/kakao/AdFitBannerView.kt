package com.orot.subwayody.ad.kakao

import android.content.Context
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.widget.LinearLayout
import com.kakao.adfit.ads.AdError
import com.kakao.adfit.ads.AdListener
import com.kakao.adfit.ads.ba.BannerAdView
import com.kakao.adfit.ads.na.*
import com.orot.subwayody.R
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugin.platform.PlatformView
import org.json.JSONException
import org.json.JSONObject

internal class AdFitBannerView(
    private val context: Context?,
    creationParams: Map<String?, Any?>?,
    binaryMessenger: BinaryMessenger
) :
    PlatformView {
    private val eventChannel = "ad.kakao_adfit_banner_channel"

    private var bannerAdView: View? = null

    private var layout: LinearLayout = LinearLayout(context).apply {
        layoutParams = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT,
            LinearLayout.LayoutParams.WRAP_CONTENT
        )
        orientation = LinearLayout.VERTICAL
    }

    override fun getView(): View {
        return layout
    }

    override fun dispose() {}

    private fun jsonToMap(jsonObject: JSONObject): Map<String, String> {
        val map: MutableMap<String, String> = HashMap()
        val keysIterator = jsonObject.keys()
        while (keysIterator.hasNext()) {
            val key = keysIterator.next()
            val value = jsonObject[key]
            map[key] = value.toString()
        }
        return map
    }

    init {
        BasicMessageChannel(
            binaryMessenger,
            eventChannel,
            StringCodec.INSTANCE
        ).setMessageHandler { message, reply ->
            try {
                val jsonObject = JSONObject(message.toString())
                val resultMap: Map<String, Any> = jsonToMap(jsonObject)

                if (resultMap["type"].toString() == AdRequestType.initialize.name){
                    adInit(reply, resultMap["adId"].toString())
                }

            } catch (e: JSONException) {
                reply.reply("error: ${e.message}")
            }

        }
    }

    private fun adInit(reply: BasicMessageChannel.Reply<String>, adId: String){
        bannerAdView = LayoutInflater.from(context).inflate(R.layout.item_banner_ad, layout, false)
        layout.removeAllViews()
        layout.addView(bannerAdView)

        layout.findViewById<BannerAdView>(R.id.adView).apply {
            setClientId(adId)
            setAdListener(object : AdListener{
                override fun onAdLoaded() {
                    reply.reply("onAdLoaded")
                }

                override fun onAdFailed(p0: Int) {
                    reply.reply("onAdFailed $p0")
                }

                override fun onAdClicked() {
                    reply.reply("onAdClicked")
                }
            })
        }.run {
            loadAd()
        }
    }
}