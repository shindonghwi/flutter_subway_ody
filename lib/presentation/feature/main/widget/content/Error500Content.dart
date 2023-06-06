import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class Error500Content extends HookWidget {
  const Error500Content({Key? key}) : super(key: key);

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
                getAppLocalizations(context).message_server_error_5xx,
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
