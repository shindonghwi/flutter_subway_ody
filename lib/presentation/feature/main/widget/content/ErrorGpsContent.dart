import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class ErrorGpsContent extends HookWidget {
  const ErrorGpsContent({Key? key}) : super(key: key);

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
                'assets/imgs/empty_gps.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 8),
              Text(
                getAppLocalizations(context).message_gps_disable,
                style: getTextTheme(context).regular.copyWith(
                      fontSize: 16,
                      color: const Color(0xFFB1B1B1),
                      height: 1.42,
                    ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: getColorScheme(context).colorPrimary,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 9),
                      child: Text(
                        getAppLocalizations(context).commonEnable,
                        style: getTextTheme(context).medium.copyWith(
                              color: getColorScheme(context).white,
                              fontSize: 16,
                            ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
