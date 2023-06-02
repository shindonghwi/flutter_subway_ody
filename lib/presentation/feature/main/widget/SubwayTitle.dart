import 'package:flutter/material.dart';
import 'package:subway_ody/presentation/feature/main/models/NearByStation.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/SubwayUtil.dart';

/// 지하철역 타이틀 및 지하철역 까지 거리
class SubwayTitle extends StatelessWidget {
  final String subwayLine;
  final String subwayName;
  final String distance;
  final Color mainColor;

  const SubwayTitle({
    super.key,
    required this.subwayLine,
    required this.subwayName,
    required this.distance,
    required this.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    final hoSun = SubwayUtil.parseSubwayHoSun(subwayLine);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: hoSun.length == 1 ? 30 : 100,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(hoSun.length == 1 ? 100 : 14),
            border: Border.all(
              color: mainColor,
              width: 1,
            ),
            color: mainColor,
          ),
          child: Center(
            child: Text(
              SubwayUtil.parseSubwayHoSun(subwayLine),
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
          subwayName,
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
      ],
    );
  }
}
