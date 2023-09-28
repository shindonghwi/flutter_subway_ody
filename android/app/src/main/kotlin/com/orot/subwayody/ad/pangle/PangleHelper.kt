//package com.orot.subwayody.ad.pangle
//
//import android.content.Context
//import android.util.Log
//import com.bytedance.sdk.openadsdk.api.banner.*
//import com.bytedance.sdk.openadsdk.api.init.PAGConfig
//import com.bytedance.sdk.openadsdk.api.init.PAGSdk
//import com.orot.subwayody.R
//import com.orot.subwayody.BuildConfig
//import com.orot.subwayody.ad.AdvertiseListener
//
//object PangleHelper {
//
//    const val TAG: String = "PangleHelper_LOG"
//    const val pangleAppId: String = "8143742"
//
//    fun initialize(context: Context) {
//        val pageConfig = PAGConfig.Builder()
//            .appId(pangleAppId) // 앱 ID 설정
//            .appIcon(R.mipmap.ic_launcher) // Open Ad 형식을 사용하는 경우 앱의 아이콘을 설정
//            .setGDPRConsent(0) // GDPR 구성 설정, 0: 동의하지 않음, 1: 동의
//            .setChildDirected(0) // COPPA 구성 설정, 0:성인, 1:어린이
//            .setDoNotSell(1) // CCPA의 구성 설정, 0: 개인정보 "판매" 허용, 1: 사용자가 개인정보 "판매" 거부
//            .supportMultiProcess(false) // 다중 프로세스 지원 설정, 기본값은 false
//            .setPackageName(BuildConfig.APPLICATION_ID) // 앱 패키지 이름 설정
//            .debugLog(false) // 디버그 모드 설정
//            .build()
//
//        PAGSdk.init(context, pageConfig, object : PAGSdk.PAGInitCallback {
//            override fun success() {
//                Log.w(TAG, "success: ")
//                Log.w(TAG, "success version ${PAGSdk.getSDKVersion()}")
//                Log.w(TAG, "success isInitSuccess ${PAGSdk.isInitSuccess()}")
//            }
//
//            override fun fail(p0: Int, p1: String?) {
//                Log.w(TAG, "fail: $p0 | $p1")
//            }
//        })
//    }
//
//    fun getBannerRequest(bannerSize: PAGBannerSize): PAGBannerRequest {
//        when (bannerSize) {
//            PAGBannerSize.BANNER_W_320_H_50 -> {
//                return PAGBannerRequest(PAGBannerSize.BANNER_W_320_H_50)
//            }
//            PAGBannerSize.BANNER_W_728_H_90 -> {
//                return PAGBannerRequest(PAGBannerSize.BANNER_W_728_H_90)
//            }
//            PAGBannerSize.BANNER_W_300_H_250 -> {
//                return PAGBannerRequest(PAGBannerSize.BANNER_W_300_H_250)
//            }
//        }
//        throw Exception("PangleHelper.getBannerRequest() : bannerSize is not defined")
//    }
//
//    // 배너 로드
//    fun loadBannerAd(
//        placementId: String,
//        bannerRequest: PAGBannerRequest,
//        advertiseListener: AdvertiseListener<PAGBannerAd?>?
//    ) {
//        PAGBannerAd.loadAd(placementId, bannerRequest, object : PAGBannerAdLoadListener {
//            override fun onError(p0: Int, p1: String?) {
//                /**
//                 * 이 메서드는 광고 로드에 실패할 때 호출됩니다.
//                 * 여기에는 발생한 오류 유형을 나타내는 Error 유형의 오류 매개변수가 포함됩니다.
//                 * 자세한 내용은 ErrorCode 섹션을 참조하십시오.
//                 * https://www.pangleglobal.com/integration/android-banner-ads-sdk
//                 * */
//                advertiseListener?.onAdFailed("p0: $p0 | p1: $p1")
//                Log.w(TAG, "onAdFailed: $p0 | $p1")
//            }
//
//            override fun onAdLoaded(ad: PAGBannerAd?) {
//                /**
//                 * 이 메서드는 광고 소재가 성공적으로 로드되었을 때 실행됩니다.
//                 * */
//                advertiseListener?.onAdLoaded(ad)
//
//                /**
//                 * 광고 이벤트 콜백 등록
//                 * */
//                setAdCallback(ad, advertiseListener)
//                Log.w(TAG, "onAdLoaded")
//            }
//        })
//    }
//
//    fun setAdCallback(
//        ad: PAGBannerAd?,
//        advertiseListener: AdvertiseListener<PAGBannerAd?>?
//    ) {
//        ad?.apply {
//            setAdInteractionListener(object : PAGBannerAdInteractionListener {
//                override fun onAdShowed() {
//                    // 이 메서드는 광고가 표시되어 기기 화면을 덮을 때 호출됩니다.
//                    advertiseListener?.onAdShow()
//                }
//
//                override fun onAdClicked() {
//                    // 이 메소드는 사용자가 광고를 클릭할 때 호출됩니다.
//                    advertiseListener?.onAdClick()
//                }
//
//                override fun onAdDismissed() {
//                    // 이 메서드는 광고가 사라질 때 호출됩니다.
//                    advertiseListener?.onAdDismiss()
//                }
//            })
//        }
//    }
//
//}