import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/presentation/feature/setting/models/LanguageType.dart';
import 'package:subway_ody/presentation/navigation/Route.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/dto/Pair.dart';

class EtcContainer extends StatelessWidget {
  const EtcContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "기타",
            style: getTextTheme(context).bold.copyWith(
                  color: const Color(0xFF2F2F2F),
                  fontSize: 12,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            "언어",
            style: getTextTheme(context).regular.copyWith(
                  color: const Color(0xFF2F2F2F),
                  fontSize: 16,
                ),
          ),
          const LanguageSelector(),
          const VersionText()
        ],
      ),
    );
  }
}

class LanguageSelector extends HookWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Pair<String, LanguageType>> languageList = [
      Pair("한국어", LanguageType.KOR),
      Pair("English", LanguageType.ENG),
      Pair("日本語", LanguageType.JPN),
      Pair("中文", LanguageType.CHN),
    ];

    showChangeLanguagePopUp(Function(bool) callback) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: getColorScheme(ctx).light,
          content: Text(
            '선택한 언어로 변경하시겠습니까?\n(앱이 재시작됩니다)',
            style: getTextTheme(context).regular.copyWith(
                  color: const Color(0xFF2F2F2F),
                  fontSize: 14,
                  height: 1.4,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () => callback.call(false),
              child: Text(
                '아니오',
                style: getTextTheme(ctx).medium.copyWith(
                      color: const Color(0xFF7C7C7C),
                      fontSize: 12,
                    ),
              ),
            ),
            TextButton(
              onPressed: () => callback.call(true),
              child: Text(
                '네',
                style: getTextTheme(context).medium.copyWith(
                      color: getColorScheme(ctx).colorPrimary,
                      fontSize: 12,
                    ),
              ),
            ),
          ],
        ),
      );
    }

    final selectedLanguageIndex = useState<LanguageType>(languageList.first.second);

    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: languageList.asMap().entries.map((e) {
          int index = e.key;
          String value = e.value.first;
          LanguageType type = e.value.second;

          return Container(
            decoration: BoxDecoration(
              color: selectedLanguageIndex.value == e.value.second
                  ? getColorScheme(context).colorPrimary
                  : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  showChangeLanguagePopUp((callback) {
                    Navigator.of(context).pop(true);
                    if (callback) {
                      selectedLanguageIndex.value = type;
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutingScreen.Splash.route,
                        (Route<dynamic> route) => false,
                      );
                    }
                  });
                },
                borderRadius: BorderRadius.circular(100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: Text(
                    value,
                    style: getTextTheme(context).medium.copyWith(
                          color: selectedLanguageIndex.value == e.value.second
                              ? getColorScheme(context).white
                              : const Color(0xFFB1B1B1),
                          fontSize: 14,
                          height: 1.28,
                        ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class VersionText extends StatelessWidget {
  const VersionText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "버전",
            style: getTextTheme(context).regular.copyWith(
                  color: const Color(0xFF2F2F2F),
                  fontSize: 16,
                ),
          ),
          Text(
            "1.0.0",
            style: getTextTheme(context).medium.copyWith(
                  color: getColorScheme(context).colorPrimary,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}
