import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/usecases/local/GetLanguageUseCase.dart';
import 'package:subway_ody/presentation/navigation/Route.dart';
import 'package:subway_ody/presentation/ui/theme.dart';

class SubwayOdyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const SubwayOdyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth != 0) {
          return FutureBuilder(
            future: GetIt.instance<GetLanguageUseCase>().call(),
            builder: (context, snapshot) {

              debugPrint("snapshot: $snapshot");
              debugPrint("snapshot: ${snapshot.data as Locale}");
              debugPrint("asdads: ${(snapshot.data as Locale) == Locale('en')}");

              if (snapshot.hasData) {
                return MaterialApp(
                  // app default option
                  onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,

                  // 시스템 테마 설정 (라이트, 다크 모드)
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: ThemeMode.system,

                  // 앱 Localization ( 영어, 한국어 지원 )
                  // supportedLocales: AppLocalizations.supportedLocales,
                  supportedLocales: [snapshot.data!],
                  localizationsDelegates: AppLocalizations.localizationsDelegates,

                  debugShowCheckedModeBanner: true,

                  initialRoute: RoutingScreen.Splash.route,
                  routes: RoutingScreen.getAppRoutes(),

                  navigatorKey: navigatorKey,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

