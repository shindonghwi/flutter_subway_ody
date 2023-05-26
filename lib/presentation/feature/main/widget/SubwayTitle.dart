import 'package:flutter/material.dart';
import 'package:subway_ody/presentation/feature/main/widget/MainAppBar.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

/// 지하철역 타이틀 및 지하철역 까지 거리
class SubwayTitle extends StatelessWidget {
  const SubwayTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              "1",
              style: getTextTheme(context).bold.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8,),
        Text(
          "개봉역",
          style: getTextTheme(context).bold.copyWith(
            color: const Color(0xFF2F2F2F),
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(width: 4,),
        Text(
          "730m",
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
