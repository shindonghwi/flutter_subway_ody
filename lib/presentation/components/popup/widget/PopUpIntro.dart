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
        const SizedBox(height: 16),
        Text(
          getAppLocalizations(context).popup_intro_menu_title,
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
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: getAppLocalizations(context).popup_intro_menu_description_1,
                      style: getTextTheme(context).medium.copyWith(
                            color: const Color(0xFF7C7C7C),
                            fontSize: 12,
                            height: 1.28,
                          ),
                    ),
                    TextSpan(
                      text: getAppLocalizations(context).popup_intro_menu_description_2,
                      style: getTextTheme(context).medium.copyWith(
                            color: getColorScheme(context).colorPrimary,
                            fontSize: 12,
                            height: 1.28,
                          ),
                    ),
                    TextSpan(
                      text: getAppLocalizations(context).popup_intro_menu_description_3,
                      style: getTextTheme(context).medium.copyWith(
                            color: const Color(0xFF7C7C7C),
                            fontSize: 12,
                            height: 1.28,
                          ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                getAppLocalizations(context).popup_intro_menu_description_4,
                style: getTextTheme(context).regular.copyWith(
                      color: const Color(0xFF7C7C7C),
                      fontSize: 12,
                  height: 1.28,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
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
