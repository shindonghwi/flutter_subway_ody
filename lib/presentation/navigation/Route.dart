import 'package:flutter/material.dart';
import 'package:subway_ody/firebase/Analytics.dart';
import 'package:subway_ody/presentation/feature/hidden/HiddenScreen.dart';
import 'package:subway_ody/presentation/feature/main/MainScreen.dart';
import 'package:subway_ody/presentation/feature/naver_map/NaverMapScreen.dart';
import 'package:subway_ody/presentation/feature/naver_map/model/MapAppBarModel.dart';
import 'package:subway_ody/presentation/feature/setting/SettingScreen.dart';
import 'package:subway_ody/presentation/feature/splash/SplashScreen.dart';

enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시
  Main(route: "/main"), // 메인
  Setting(route: "/setting"), // 설정
  NaverMap(route: "/map/naver"), // 네이버 지도 화면
  Hidden(route: "/hidden"); // 숨겨진 화면 ( 위치 수동 설정 )

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => const SplashScreen(),
      RoutingScreen.Main.route: (context) => const MainScreen(),
      RoutingScreen.Setting.route: (context) => const SettingScreen(),
      RoutingScreen.NaverMap.route: (context) => NaverMapScreen(),
      RoutingScreen.Hidden.route: (context) => HiddenScreen(),
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
      case "/map/naver":
        MapAppBarModel model = parameter;
        return NaverMapScreen(model: model);
      case "/hidden":
        return HiddenScreen();
      default: // default는 무조건 splash로 이동
        return const SplashScreen();
    }
  }
}
