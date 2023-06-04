import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/presentation/feature/main/MainIntent.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayDirectionETA.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayListDivider.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayTitle.dart';

class ActiveContent extends HookWidget {
  final MainIntent subwayModel;

  const ActiveContent({super.key, required this.subwayModel});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
            children: subwayModel.subwayItems.map((model) {
          return Column(
            children: [
              const SizedBox(height: 32),
              SubwayTitle(
                subwayId: model.subwayId,
                subwayName: model.subwayName,
                distance: model.distance,
                mainColor: model.mainColor,
              ),
              const SizedBox(height: 22),
              SubwayDirectionETA(stationInfo: model.stationInfoList.first),
              const SizedBox(height: 28),
              SubwayListDivider(stationInfo: model.stationInfoList.first, mainColor: model.mainColor,),
              const SizedBox(height: 74),
              SubwayDirectionETA(stationInfo: model.stationInfoList.last),
              const SizedBox(height: 28),
              SubwayListDivider(stationInfo: model.stationInfoList.last, mainColor: model.mainColor,),
              const SizedBox(height: 74),

              // AdvertiseContainer(),
            ],
          );
        }).toList()));
  }
}
