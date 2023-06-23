import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:subway_ody/app/env/Environment.dart';
import 'package:subway_ody/firebase/FirebaseRemoteConfigService.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseRemoteConfigService().initialize();

  // 모든 오류 기록
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // 플러터 외부 오류 기록
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );
  }).sendPort);

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);

  Environment.newInstance(BuildType.dev).run();
}
