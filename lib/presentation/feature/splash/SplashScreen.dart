import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/presentation/navigation/PageMoveUtil.dart';
import 'package:subway_ody/presentation/navigation/Route.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      // 1초뒤에 화면이동
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pushReplacement(
          context,
          nextFadeInOutScreen(RoutingScreen.Main.route),
        );
      });
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
