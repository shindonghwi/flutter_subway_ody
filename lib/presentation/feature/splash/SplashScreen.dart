import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/data/data_source/remote/Service.dart';
import 'package:subway_ody/domain/usecases/local/GetAutoRefreshCallUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetLocationPermissionUseCase.dart';
import 'package:subway_ody/firebase/FirebaseRemoteConfigService.dart';
import 'package:subway_ody/presentation/components/toast/Toast.dart';
import 'package:subway_ody/presentation/feature/provider/AutoRefreshNotifier.dart';
import 'package:subway_ody/presentation/navigation/PageMoveUtil.dart';
import 'package:subway_ody/presentation/navigation/Route.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNetworkConnected = useState<bool>(true);
    final autoRefreshRead = ref.read(autoRefreshProvider.notifier);

    moveMainPage() {
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.pushReplacement(
          context,
          nextFadeInOutScreen(RoutingScreen.Main.route),
        );
      });
    }

    showExitPopup() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text(
            getAppLocalizations(context).message_gps_permission,
            style: getTextTheme(context).regular.copyWith(
                  color: const Color(0xFF7C7C7C),
                  fontSize: 12,
                  height: 1.28,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop(animated: true);
                } else {
                  FlutterExitApp.exitApp(iosForceExit: true);
                }
              },
              child: Text(
                getAppLocalizations(context).common_do_exit,
                style: getTextTheme(context).medium.copyWith(
                      color: const Color(0xFF7C7C7C),
                      fontSize: 12,
                    ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(ctx).pop(true);
                if (Platform.isAndroid) {
                  GetIt.instance<GetLocationPermissionUseCase>().call().then((value) {
                    if (value) {
                      moveMainPage();
                    } else {
                      showExitPopup();
                    }
                  });
                } else {
                  AppSettings.openAppSettings();
                }
              },
              child: Text(
                Platform.isAndroid
                    ? getAppLocalizations(context).common_do_request
                    : getAppLocalizations(context).common_do_setting,
                style: getTextTheme(ctx).medium.copyWith(
                      color: getColorScheme(ctx).colorPrimary,
                      fontSize: 12,
                    ),
              ),
            ),
          ],
        ),
      );
    }

    requestGpsPermission() async {
      return await GetIt.instance<GetLocationPermissionUseCase>().call().then((value) {
        if (value) {
          moveMainPage();
        } else {
          // 위치 권한이 없을 경우
          showExitPopup();
        }
      });
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // 새로고침 여부 가져오기
        await GetIt.instance<GetAutoRefreshCallUseCase>().call().then((value) {
          debugPrint("새로고침 여부 가져오기 : $value");
          autoRefreshRead.setMode(value);
        });
      });
      return null;
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        isNetworkConnected.value = await Service.isNetworkAvailable();

        if (isNetworkConnected.value) {
          // 네트워크 연결이 되어있을 경우
          requestGpsPermission();
        }
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: getColorScheme(context).white,
      body: Container(
        color: getColorScheme(context).colorPrimary,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Center(
              child: Image.asset(
                "assets/imgs/splash_image.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (!isNetworkConnected.value)
            Container(
              width: getMediaQuery(context).size.width,
              height: getMediaQuery(context).size.height,
              color: getColorScheme(context).black.withOpacity(0.5),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                  decoration: BoxDecoration(
                    color: getColorScheme(context).white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        getAppLocalizations(context).message_network_error,
                        style: getTextTheme(context).medium.copyWith(
                              color: getColorScheme(context).neutral80,
                              fontSize: 16,
                              height: 1.44,
                            ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          color: getColorScheme(context).colorPrimary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              if (!await Service.isNetworkAvailable()) {
                                ToastUtil.errorToast(getAppLocalizations(context).message_network_error);
                              } else {
                                await FirebaseRemoteConfigService().initialize();
                                requestGpsPermission();
                              }
                            },
                            borderRadius: BorderRadius.circular(25),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                              child: Text(
                                "재시도하기",
                                style: getTextTheme(context).medium.copyWith(
                                      color: getColorScheme(context).white,
                                      fontSize: 16,
                                      height: 1.44,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
