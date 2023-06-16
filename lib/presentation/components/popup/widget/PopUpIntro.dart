import 'package:flutter/material.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class PopUpIntro extends StatelessWidget {
  const PopUpIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        Image.asset(
          'assets/imgs/marker.png',
          width: 20,
          height: 24,
        ),
        const SizedBox(height: 32),
        Text(
          '지하철 오디 알림',
          style: getTextTheme(context).bold.copyWith(
                color: const Color(0xFF2F2F2F),
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '현재는 서울 지하철(서울, 경기 또는 수도권 지역) 서비스를 제공하고 있습니다.',
                style: getTextTheme(context).regular.copyWith(
                      color: const Color(0xFF7C7C7C),
                      fontSize: 12,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '곧 부산지하철(부산지역)이 오픈됩니다. 커밍 쑨!!',
                style: getTextTheme(context).regular.copyWith(
                      color: const Color(0xFF7C7C7C),
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
            color: getColorScheme(context).colorPrimary,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(5)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '확인',
                  style: getTextTheme(context).medium.copyWith(
                        color: getColorScheme(context).white,
                        fontSize: 14,
                      ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
