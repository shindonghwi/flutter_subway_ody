import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/presentation/feature/main/models/SubwayModel.dart';
import 'package:subway_ody/presentation/feature/setting/models/LanguageType.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/SubwayUtil.dart';
import 'package:subway_ody/presentation/utils/SystemUtil.dart';
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
    LanguageType type = SystemUtil.getLanguageType(SubwayOdyApp.currentLocale);

    final double horizontalPadding;
    final double spacing;
    final double contentWidth;

    if (type == LanguageType.ENG) {
      horizontalPadding = getMediaQuery(context).size.width * 0.03;
      spacing = getMediaQuery(context).size.width * 0.088;
      contentWidth = getMediaQuery(context).size.width * 0.23;
    } else {
      horizontalPadding = getMediaQuery(context).size.width * 0.064;
      spacing = getMediaQuery(context).size.width * 0.088;
      contentWidth = getMediaQuery(context).size.width * 0.174;
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      child: Stack(
          fit: StackFit.expand,
          children: List.generate(positionList.length, (index) {
            return Positioned.fill(
              left: index * spacing,
              child: Align(
                alignment: Alignment.centerLeft,
                child: positionList[index].first != -1
                    ? SizedBox(
                        width: contentWidth, // 첫 번째 아이템의 넓이
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
          }).reversed.toList()),
    );
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
    LanguageType type = SystemUtil.getLanguageType(SubwayOdyApp.currentLocale);

    final languageDestination = SubwayUtil.findLanguageSubwayName(
      destination,
      isDestination: true,
      isPositionData: true,
      languageType: type,
    );

    var languageBtrainStttus = btrainSttus;

    if (type == LanguageType.ENG) {
      if (btrainSttus == "급행") {
        languageBtrainStttus = "express";
      } else if (btrainSttus == "일반") {
        languageBtrainStttus = "normal";
      }
    } else if (type == LanguageType.JPN) {
      if (btrainSttus == "급행") {
        languageBtrainStttus = "急行";
      } else if (btrainSttus == "일반") {
        languageBtrainStttus = "普通";
      }
    } else if (type == LanguageType.CHN) {
      if (btrainSttus == "급행") {
        languageBtrainStttus = "快车";
      } else if (btrainSttus == "일반") {
        languageBtrainStttus = "普通";
      }
    }

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
              Text(
                languageDestination,
                style: getTextTheme(context).bold.copyWith(
                      color: const Color(0xFF2F2F2F),
                      fontSize: 12,
                    ),
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                "($languageBtrainStttus)",
                style: getTextTheme(context).medium.copyWith(
                      color: const Color(0xFF2F2F2F),
                      fontSize: 8,
                    ),
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
              ),
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
