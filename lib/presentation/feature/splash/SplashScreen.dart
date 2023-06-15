import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/domain/usecases/local/GetAutoRefreshCallUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetLocationPermissionUseCase.dart';
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
            '앱을 사용하기 위해서 위치 권한이 필요합니다',
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
                '종료하기',
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
                Platform.isAndroid ? '요청하기' : '설정하기',
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
      debugPrint("SplashScreen useEffect");
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // 새로고침 여부 가져오기
        await GetIt.instance<GetAutoRefreshCallUseCase>().call().then((value) {
          debugPrint("새로고침 여부 가져오기 : $value");
          autoRefreshRead.setMode(value);
        });

        // 위치권한 가져오기
        requestGpsPermission();
      });
    }, []);

    return Container(
      color: getColorScheme(context).colorPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: LifecycleWatcher(
        onLifeCycleChanged: (state) {
          if (state == AppLifecycleState.resumed) {
            requestGpsPermission();
          }
        },
      ),
    );
  }
}

class LifecycleWatcher extends StatefulWidget {
  final Function(dynamic state) onLifeCycleChanged;

  const LifecycleWatcher({
    Key? key,
    required this.onLifeCycleChanged,
  }) : super(key: key);

  @override
  State<LifecycleWatcher> createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher> with WidgetsBindingObserver {
  late AppLifecycleState _lastLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        print("## detached");
        break;
      case AppLifecycleState.inactive:
        print("## inactive");
        break;
      case AppLifecycleState.paused:
        print("## paused");
        break;
      case AppLifecycleState.resumed:
        print("## resumed");
        break;
    }

    setState(() {
      widget.onLifeCycleChanged(state);
      _lastLifecycleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/imgs/splash_image.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
