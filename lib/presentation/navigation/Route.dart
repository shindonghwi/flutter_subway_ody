import 'package:flutter/material.dart';
import 'package:subway_ody/presentation/feature/main/MainScreen.dart';
import 'package:subway_ody/presentation/feature/setting/SettingScreen.dart';
import 'package:subway_ody/presentation/feature/splash/SplashScreen.dart';

enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시
  Main(route: "/main"), // 메인
  Setting(route: "/settting"); // 설정

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => const SplashScreen(),
      RoutingScreen.Main.route: (context) => const MainScreen(),
      RoutingScreen.Setting.route: (context) => const SettingScreen(),
    };
  }

  static getScreen(String route, {dynamic parameter}) {
    debugPrint("getScreen : parameter: $parameter");
    switch (route) {
      case "/splash":
        return const SplashScreen();
      case "/main":
        return const MainScreen();
      case "/setting":
        return const SettingScreen();
      default: // default는 무조건 splash로 이동
        return const SplashScreen();
    }
  }
}
