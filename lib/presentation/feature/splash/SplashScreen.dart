import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/usecases/local/app/GetLocationPermissionUseCase.dart';
import 'package:subway_ody/presentation/navigation/PageMoveUtil.dart';
import 'package:subway_ody/presentation/navigation/Route.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        useEffect(() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            GetIt.instance<GetLocationPermissionUseCase>().call().then((value) {
                if (value) {
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    Navigator.pushReplacement(
                      context,
                      nextFadeInOutScreen(RoutingScreen.Main.route),
                    );
                  });
                } else {
                  // 위치 권한이 없을 경우
                }
            });
          });
        }, []);
      },
    );

    useEffect(() {

    }, []);

    return Container(
      color: getColorScheme(context).colorPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Center(
        child: Image.asset(
          "assets/imgs/splash_image.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
