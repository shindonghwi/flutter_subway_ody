import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:subway_ody/app/env/Environment.dart';
import 'package:subway_ody/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class Crashlytics{

  static void init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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

    // dev 모드인 경우에 오류 보고를 수집 하지 않음.
    if (Environment.buildType == BuildType.dev) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      return;
    }
  }

}