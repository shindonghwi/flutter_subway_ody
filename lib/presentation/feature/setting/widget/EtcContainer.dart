import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/domain/usecases/local/GetAppModeUseCase.dart';
import 'package:subway_ody/domain/usecases/local/PatchAppModeUseCase.dart';
import 'package:subway_ody/domain/usecases/local/PostSaveUserLanguageUseCase.dart';
import 'package:subway_ody/firebase/Analytics.dart';
import 'package:subway_ody/presentation/components/popup/PopupUtil.dart';
import 'package:subway_ody/presentation/feature/setting/models/LanguageType.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/RestartWidget.dart';
import 'package:subway_ody/presentation/utils/SystemUtil.dart';
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
            getAppLocalizations(context).settingMenuEtc,
            style: getTextTheme(context).bold.copyWith(
                  color: const Color(0xFF2F2F2F),
                  fontSize: 12,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            getAppLocalizations(context).settingMenuEtcLanguage,
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
            getAppLocalizations(context).change_language_dialog_body,
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
                getAppLocalizations(context).commonCancel,
                style: getTextTheme(ctx).medium.copyWith(
                      color: const Color(0xFF7C7C7C),
                      fontSize: 12,
                    ),
              ),
            ),
            TextButton(
              onPressed: () => callback.call(true),
              child: Text(
                getAppLocalizations(context).commonConfirm,
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

    useEffect(() {
      initLanguage() async {
        selectedLanguageIndex.value = SystemUtil.getLanguageType(
          SubwayOdyApp.currentLocale,
        );
      }

      initLanguage();
    }, [selectedLanguageIndex]);

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
                  showChangeLanguagePopUp((callback) async {
                    Navigator.of(context).pop(true);
                    if (callback) {
                      Analytics.eventSetLanguage(type);
                      selectedLanguageIndex.value = type;
                      await GetIt.instance<PostSaveUserLanguageUseCase>().call(type);
                      RestartWidget.restartApp(context);
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

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    int hiddenMenuClickCount = 0;

    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getAppLocalizations(context).settingMenuEtcVersion,
            style: getTextTheme(context).regular.copyWith(
                  color: const Color(0xFF2F2F2F),
                  fontSize: 16,
                ),
          ),
          FutureBuilder(
            future: getAppVersion(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GestureDetector(
                  onTap: () async {
                    hiddenMenuClickCount++;

                    if (hiddenMenuClickCount == 10) {
                      PopupUtil.showHiddenMenu(backgroundTouchCloseFlag: false);
                      hiddenMenuClickCount = 0;
                    }
                  },
                  child: Text(
                    snapshot.data.toString(),
                    style: getTextTheme(context).medium.copyWith(
                          color: getColorScheme(context).colorPrimary,
                          fontSize: 14,
                        ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
