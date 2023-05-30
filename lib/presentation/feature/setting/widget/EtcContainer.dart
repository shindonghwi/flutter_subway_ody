import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

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
    final languageList = [
      "한국어",
      "English",
      "日本語",
      "中文",
    ];

    final selectedLanguageIndex = useState<String>(languageList.first);

    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: languageList.asMap().entries.map((e) {
          int index = e.key;
          String value = e.value;

          return Container(
            decoration: BoxDecoration(
              color: selectedLanguageIndex.value == e.value
                  ? getColorScheme(context).colorPrimary
                  : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  selectedLanguageIndex.value = value;
                },
                borderRadius: BorderRadius.circular(100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: Text(
                    value,
                    style: getTextTheme(context).medium.copyWith(
                          color: selectedLanguageIndex.value == e.value
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