import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

    final subWayInfoWidget = ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 16); // Adjust the height as needed
      },
      itemBuilder: (BuildContext context, int index) {
        final item = subwayModel.subwayItems[index];

        return Column(
          children: [
            const SizedBox(height: 48),
            SubwayTitle(
              subwayLine: item.subwayLine,
              subwayName: item.subwayName,
              distance: item.distance,
              mainColor: item.mainColor,
              latLng: item.latLng,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16); // Adjust the height as needed
              },
              itemBuilder: (BuildContext context, int index) {
                final model = item.stations[index];

                return Column(
                  children: [
                    const SizedBox(height: 22),
                    SubwayDirectionETA(stationInfo: model),
                    const SizedBox(height: 28),
                    SubwayListDivider(
                      stationInfo: model,
                      mainColor: item.mainColor,
                    ),
                    const SizedBox(height: 74),
                  ],
                );
              },
              itemCount: item.stations.length,
            ),
          ],
        );
      },
      itemCount: subwayModel.subwayItems.length,
    );

    return !isAllEmpty ? subWayInfoWidget : const ErrorNotAvailableContent();
  }
}
