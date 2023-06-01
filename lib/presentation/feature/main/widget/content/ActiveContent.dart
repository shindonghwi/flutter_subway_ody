import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/presentation/feature/main/MainIntent.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayDirectionETA.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayTitle.dart';
import 'package:subway_ody/presentation/utils/SubwayUtil.dart';

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
          final mainColor =
              SubwayUtil.getMainColor(context, model.nearByStation.subwayLine);
          return Column(
            children: [
              const SizedBox(height: 32),
              SubwayTitle(
                nearByStation: model.nearByStation,
                mainColor: mainColor,
              ),
              const SizedBox(height: 22),
              SubwayDirectionETA(arrivalItem: model.subwayArrivalList.first)
            ],
          );
          // children: [
          //   const SizedBox(height: 32),
          //   SubwayTitle(
          //     nearByStation: e.nearByStation,
          //     mainColor: mainColor,
          //   ),
          //   const SizedBox(height: 22),
          //   SubwayDirectionETA(),
          // ],
          // );
        }).toList()));
    // child: Column(
    //   children: const [
    //     SizedBox(height: 32),
    //     SubwayTitle(),
    // SizedBox(height: 22),
    // SubwayDirectionETA(),
    // SizedBox(height: 28),
    // SubwayListDivider(),
    // SizedBox(height: 74),
    // SubwayDirectionETA(),
    // SizedBox(height: 28),
    // SubwayListDivider(),
    // AdvertiseContainer(),
    // SizedBox(height: 32),
    // SubwayTitle(),
    // SizedBox(height: 22),
    // SubwayDirectionETA(),
    // SizedBox(height: 28),
    // SubwayListDivider(),
    // SizedBox(height: 74),
    // SubwayDirectionETA(),
    // SizedBox(height: 28),
    // SubwayListDivider(),
    // AdvertiseContainer(),
    // ],
    // ),
    // );
  }
}
