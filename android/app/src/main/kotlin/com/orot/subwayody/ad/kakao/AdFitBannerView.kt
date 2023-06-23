package com.orot.subwayody.ad.kakao

import android.app.Activity
import android.content.Context
import android.content.ContextWrapper
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.widget.LinearLayout
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.OnLifecycleEvent
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

        val adView = layout.findViewById<BannerAdView>(R.id.adView)

        adView.apply {
            Log.w("zxccxzcxzzxczcx", "adId:  $adId", )
            setClientId(adId)
            setAdListener(object : AdListener{
                override fun onAdLoaded() {
                    Log.w("zxccxzcxzzxczcx", "onAdLoaded: ", )
                }

                override fun onAdFailed(p0: Int) {
                    Log.w("zxccxzcxzzxczcx", "onAdFailed: ", )
                }

                override fun onAdClicked() {
                    Log.w("zxccxzcxzzxczcx", "onAdClicked: ", )
                }
            })
        }.run {
            loadAd()
        }

        val lifecycle: Lifecycle? = getLifecycleFromContext(context)
        attachLifecycleToAdView(context, lifecycle, adView)
    }

    fun getActivityFromContext(context: Context?): Activity? {
        if (context is Activity) {
            return context
        } else if (context is ContextWrapper) {
            return getActivityFromContext(context.baseContext)
        }
        return null
    }

    fun getLifecycleFromContext(context: Context?): Lifecycle? {
        if (context is LifecycleOwner) {
            return context.lifecycle
        } else if (context is ContextWrapper) {
            return getLifecycleFromContext(context.baseContext)
        }
        return null
    }


    fun attachLifecycleToAdView(context: Context?, lifecycle: Lifecycle?, adView: BannerAdView) {
        getActivityFromContext(context)?.apply {
            lifecycle?.addObserver(object : LifecycleObserver {

                @OnLifecycleEvent(Lifecycle.Event.ON_RESUME)
                fun onResume() {
                    adView.resume()
                }

                @OnLifecycleEvent(Lifecycle.Event.ON_PAUSE)
                fun onPause() {
                    adView.pause()
                }

                @OnLifecycleEvent(Lifecycle.Event.ON_DESTROY)
                fun onDestroy() {
                    adView.destroy()
                }
            })
        }
    }


}