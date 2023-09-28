import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:subway_ody/app/env/Environment.dart';
import 'package:subway_ody/presentation/components/ad/AdvertiseHelper.dart';

import 'PangleAdBanner.dart';

class GoogleAdmobBanner extends HookWidget {
  final AdSize size;

  const GoogleAdmobBanner({
    Key? key,
    this.size = AdSize.banner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<BannerAd?> bannerAd = useState(null);

    void loadAd() {
      BannerAd(
        adUnitId: AdvertiseHelper.admobBannerId,
        request: const AdRequest(),
        size: size,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            bannerAd.value = ad as BannerAd;
          },
          onAdFailedToLoad: (ad, err) {
            ad.dispose();
            bannerAd.value = null;
          },
          onAdOpened: (Ad ad) {},
          onAdClosed: (Ad ad) {},
          onAdImpression: (Ad ad) {},
        ),
      ).load();
    }

    useEffect(() {
      loadAd();
      return null;
    }, []);

    return Center(
      child: SizedBox(
        width: size.width.toDouble(),
        height: size.height.toDouble(),
        child: bannerAd.value != null ? AdWidget(ad: bannerAd.value!) : const SizedBox(),
      ),
    );
  }
}
