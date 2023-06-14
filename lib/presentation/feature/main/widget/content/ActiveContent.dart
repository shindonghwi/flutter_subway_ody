import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/app/env/Environment.dart';
import 'package:subway_ody/presentation/components/ad/KakaoAdFitBanner.dart';
import 'package:subway_ody/presentation/feature/main/MainIntent.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayDirectionETA.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayListDivider.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayTitle.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ErrorNotAvailableContent.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class ActiveContent extends HookWidget {
  final MainIntent subwayModel;

  const ActiveContent({super.key, required this.subwayModel});

  @override
  Widget build(BuildContext context) {
    final isAllEmpty = subwayModel.subwayItems.any((element) => element.stations.isEmpty);

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
                        const SizedBox(height: 32),
                        SubwayTitle(
                          subwayLine: model.subwayLine,
                          subwayName: model.subwayName,
                          distance: model.distance,
                          mainColor: model.mainColor,
                        ),
                        Column(
                          children: model.stations.map((e) {
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
                              ],
                            );
                          }).toList(),
                        ),
                        if (index == 0 && Platform.isAndroid && Environment.buildType == BuildType.prod)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              width: getMediaQuery(context).size.width,
                              height: getMediaQuery(context).size.width / 2,
                              color: const Color(0xFFF5F5F5),
                              child: const KakaoAdFitBanner(),
                            ),
                          )
                      ],
                    )
                  : const SizedBox();
            }).toList()))
        : const ErrorNotAvailableContent();
  }
}
