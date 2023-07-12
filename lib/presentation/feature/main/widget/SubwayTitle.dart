import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/app/env/Environment.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/presentation/feature/naver_map/model/MapAppBarModel.dart';
import 'package:subway_ody/presentation/navigation/PageMoveUtil.dart';
import 'package:subway_ody/presentation/navigation/Route.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/SubwayUtil.dart';
import 'package:subway_ody/presentation/utils/SystemUtil.dart';

/// 지하철역 타이틀 및 지하철역 까지 거리
class SubwayTitle extends StatelessWidget {
  final String subwayLine;
  final String subwayName;
  final String distance;
  final Color mainColor;
  final LatLng latLng;

  const SubwayTitle({
    super.key,
    required this.subwayLine,
    required this.subwayName,
    required this.distance,
    required this.mainColor,
    required this.latLng,
  });

  @override
  Widget build(BuildContext context) {
    final String hosun = SubwayUtil.getSubwayHosun(subwayLine).toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: hosun.length == 1 ? 30 : 100,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(hosun.length == 1 ? 100 : 14),
            border: Border.all(
              color: mainColor,
              width: 1,
            ),
            color: mainColor,
          ),
          child: Center(
            child: Text(
              hosun,
              style: getTextTheme(context).bold.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.28,
                  ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          SubwayUtil.findLanguageSubwayName(
            subwayName,
            languageType: SystemUtil.getLanguageType(SubwayOdyApp.currentLocale),
          ),
          style: getTextTheme(context).bold.copyWith(
                color: const Color(0xFF2F2F2F),
                fontSize: 18,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          "${distance}m",
          style: getTextTheme(context).medium.copyWith(
                color: const Color(0xFF7C7C7C),
                fontSize: 16,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: getColorScheme(context).colorPrimary,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  nextSlideScreen(
                    RoutingScreen.NaverMap.route,
                    parameter: MapAppBarModel(
                      hosun: hosun,
                      subwayName: subwayName,
                      mainColor: mainColor,
                      distance: distance,
                      latLng: latLng,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(100),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset("assets/imgs/location.svg"),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      getAppLocalizations(context).common_location,
                      style: getTextTheme(context).medium.copyWith(
                            color: getColorScheme(context).white,
                            fontSize: 12,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
