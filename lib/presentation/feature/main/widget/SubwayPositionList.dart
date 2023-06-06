import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subway_ody/presentation/feature/main/models/SubwayModel.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/dto/Pair.dart';

class SubwayPositionList extends HookWidget {
  const SubwayPositionList({
    super.key,
    required this.subwayList,
    required this.positionList,
    required this.mainColor,
    required this.isUp,
    required this.destination,
    required this.btrainSttus,
  });

  final List<String> subwayList;
  final List<Pair<int, SubwayPositionModel?>> positionList;
  final Color mainColor;
  final String destination;
  final String btrainSttus;
  final bool isUp;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: getMediaQuery(context).size.width * 0.064,
        ),
        child: Stack(
            fit: StackFit.expand,
            children: List.generate(positionList.length, (index) {
              return Positioned.fill(
                left: index * getMediaQuery(context).size.width * 0.088,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: positionList[index].first != -1
                      ? SizedBox(
                          width:
                              getMediaQuery(context).size.width * 0.174, // 첫 번째 아이템의 넓이
                          child: SubwayPositionItem(
                            mainColor: mainColor,
                            isUp: isUp,
                            destination: destination,
                            btrainSttus: btrainSttus,
                          ),
                        )
                      : const SizedBox(),
                ),
              );
            }).toList()));
  }
}

class SubwayPositionItem extends StatelessWidget {
  final Color mainColor;
  final bool isUp;
  final String destination;
  final String btrainSttus;

  const SubwayPositionItem({
    Key? key,
    required this.mainColor,
    required this.isUp,
    required this.destination,
    required this.btrainSttus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Text(destination,
                  style: getTextTheme(context).bold.copyWith(
                        color: const Color(0xFF2F2F2F),
                        fontSize: 12,
                      )),
              const SizedBox(height: 4),
              Text("($btrainSttus)",
                  style: getTextTheme(context).medium.copyWith(
                        color: const Color(0xFF2F2F2F),
                        fontSize: 8,
                      )),
            ],
          ),
        ),
        Transform(
          transform: Matrix4.identity()..scale(isUp ? 1.0 : -1.0, 1.0, 1.0),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/imgs/subway.svg',
            colorFilter: ColorFilter.mode(
              mainColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
