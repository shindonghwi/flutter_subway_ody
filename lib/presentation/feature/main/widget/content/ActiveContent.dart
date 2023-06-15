import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:subway_ody/presentation/components/ad/GoogleAdmobBanner.dart';
import 'package:subway_ody/presentation/feature/main/MainIntent.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayDirectionETA.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayListDivider.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayTitle.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ErrorNotAvailableContent.dart';

class ActiveContent extends HookWidget {
  final MainIntent subwayModel;

  const ActiveContent({super.key, required this.subwayModel});

  @override
  Widget build(BuildContext context) {
    final isAllEmpty = subwayModel.subwayItems.any((element) => element.stations.isEmpty);
    final adCount = useState(0);

    return !isAllEmpty
        ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
                children: subwayModel.subwayItems.asMap().entries.map((entry) {
              final index = entry.key;
              final model = entry.value;

              return model.stations.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        if (index == 0) const GoogleAdmobBanner(size: AdSize.banner),
                        const SizedBox(height: 32),
                        SubwayTitle(
                          subwayLine: model.subwayLine,
                          subwayName: model.subwayName,
                          distance: model.distance,
                          mainColor: model.mainColor,
                        ),
                        Column(
                          children: model.stations.map((e) {
                            adCount.value += 1;
                            return Column(
                              children: [
                                const SizedBox(height: 22),
                                SubwayDirectionETA(stationInfo: e),
                                const SizedBox(height: 28),
                                SubwayListDivider(
                                  stationInfo: e,
                                  mainColor: model.mainColor,
                                ),
                                const SizedBox(height: 74),
                                if (adCount.value > 5 && adCount.value % 6 == 0) const GoogleAdmobBanner(size: AdSize.largeBanner),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  : const SizedBox();
            }).toList()))
        : const ErrorNotAvailableContent();
  }
}
