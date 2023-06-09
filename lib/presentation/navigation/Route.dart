import 'package:flutter/material.dart';
import 'package:subway_ody/firebase/Analytics.dart';
import 'package:subway_ody/presentation/feature/main/MainScreen.dart';
import 'package:subway_ody/presentation/feature/setting/SettingScreen.dart';
import 'package:subway_ody/presentation/feature/splash/SplashScreen.dart';

enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시
  Main(route: "/main"), // 메인
  Setting(route: "/setting"); // 설정

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => const SplashScreen(),
      RoutingScreen.Main.route: (context) => MainScreen(),
      RoutingScreen.Setting.route: (context) => const SettingScreen(),
    };
  }

  static getScreen(String route, {dynamic parameter}) {
    Analytics.eventScreenRecord(route);
    switch (route) {
      case "/splash":
        return const SplashScreen();
      case "/main":
        return MainScreen();
      case "/setting":
        return const SettingScreen();
      default: // default는 무조건 splash로 이동
        return const SplashScreen();
    }
  }
}
