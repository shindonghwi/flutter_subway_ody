package com.orot.subwayody.ad.kakao

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.LinearLayout
import com.kakao.adfit.ads.AdError
import com.kakao.adfit.ads.na.*
import com.orot.subwayody.R
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugin.platform.PlatformView
import org.json.JSONException
import org.json.JSONObject

internal class AdFitNativeView(
    private val context: Context?,
    creationParams: Map<String?, Any?>?,
    binaryMessenger: BinaryMessenger
) :
    PlatformView {
    private val eventChannel = "ad.kakao_adfit_native_channel"

    private var nativeAdLoader: AdFitNativeAdLoader? = null
    private var nativeAdBinder: AdFitNativeAdBinder? = null
    private var nativeAdView: View? = null

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
        nativeAdLoader = AdFitNativeAdLoader.create(context!!, adId).apply {
            val request = AdFitNativeAdRequest.Builder()
                .setAdInfoIconPosition(AdFitAdInfoIconPosition.RIGHT_TOP) // 광고 정보 아이콘 위치 설정 (container view 내에서의 광고 아이콘 위치)
                .setVideoAutoPlayPolicy(AdFitVideoAutoPlayPolicy.ALWAYS) // 비디오 광고 자동 재생 정책 설정
                .build()

            loadAd(request, object : AdFitNativeAdLoader.AdLoadListener {
                override fun onAdLoadError(errorCode: Int) {
                    when (errorCode) {
                        AdError.NO_AD.errorCode -> {
                            reply.reply("NO_AD: ")
                            // 요청에는 성공했으나 노출 가능한 광고가 없는 경우
                        }
                        AdError.HTTP_FAILED.errorCode -> {
                            reply.reply("HTTP_FAILED: ")
                            // 네트워크 오류로 광고 요청에 실패한 경우
                        }
                        else -> {
                            reply.reply("else: ")
                            // 기타 오류로 광고 요청에 실패한 경우
                        }
                    }

                    if (nativeAdBinder == null) {
                        reply.reply("nativeAdBinder null: ")
                        // TODO: 보여지고 있는 광고가 없을 때의 처리
                    } else {
                        reply.reply("nativeAdBinder not null: ")
                        // TODO: 보여지고 있는 광고가 있을 때의 처리
                    }
                }

                override fun onAdLoaded(binder: AdFitNativeAdBinder) {
                    if (nativeAdView != null) return

                    nativeAdView = LayoutInflater.from(context).inflate(R.layout.item_native_ad, layout, false)
                    layout.removeAllViews()
                    layout.addView(nativeAdView)

                    // 이전에 노출 중인 광고가 있으면 해제
                    nativeAdBinder?.unbind()

                    // 광고 SDK에 넘겨줄 [AdFitNativeAdLayout] 정보 구성
                    val nativeAdLayout: AdFitNativeAdLayout =
                        AdFitNativeAdLayout.Builder(nativeAdView!!.findViewById(R.id.containerView)) // 네이티브 광고 영역 (광고 아이콘이 배치 됩니다)
                            .setTitleView(nativeAdView!!.findViewById(R.id.titleTextView)) // 광고 제목 (필수)
                            .setBodyView(nativeAdView!!.findViewById(R.id.bodyTextView)) // 광고 홍보문구
                            .setProfileIconView(nativeAdView!!.findViewById(R.id.profileIconView)) // 광고주 아이콘 (브랜드 로고)
                            .setProfileNameView(nativeAdView!!.findViewById(R.id.profileNameTextView)) // 광고주 이름 (브랜드명)
                            .setMediaView(nativeAdView!!.findViewById(R.id.mediaView)) // 광고 미디어 소재 (이미지, 비디오) (필수)
                            .setCallToActionButton(nativeAdView!!.findViewById(R.id.callToActionButton)) // 행동유도버튼 (알아보기, 바로가기 등)
                            .build()

                    // 광고 노출
                    nativeAdBinder = binder
                    binder.bind(nativeAdLayout)
                }
            })
        }
    }
}