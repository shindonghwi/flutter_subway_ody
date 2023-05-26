import 'package:flutter/material.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

/// 지하철 방향 및 도착 예정 시간
class SubwayDirectionETA extends StatelessWidget {
  const SubwayDirectionETA({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "인천행",
          style: getTextTheme(context).medium.copyWith(
                color: const Color(0xFF676767),
                fontSize: 16,
              ),
          textAlign: TextAlign.center,
        ),

        /// 여기 아래는 도착예정 정보가 있으면 표시
        const SizedBox(
          width: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: getColorScheme(context).white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: getColorScheme(context).colorPrimary,
              width: 1,
            ),
          ),
          child: Text(
            "3분뒤 도착",
            style: getTextTheme(context).bold.copyWith(
                  color: getColorScheme(context).colorPrimary,
                  fontSize: 12,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
