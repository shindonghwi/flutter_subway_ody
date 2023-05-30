import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class ErrorNotAvailableContent extends HookWidget {
  const ErrorNotAvailableContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imgs/empty_subway.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 8),
              Text(
                "근처에 지하철역이 없거나\n아직 서비스를 지원하지 않는 지역입니다",
                style: getTextTheme(context).regular.copyWith(
                      fontSize: 16,
                      color: const Color(0xFFB1B1B1),
                      height: 1.42,
                    ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ));
  }
}