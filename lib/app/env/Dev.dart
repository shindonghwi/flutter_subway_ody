import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:subway_ody/app/env/Environment.dart';
import 'package:subway_ody/firebase/crashlytics/Crashlytics.dart';

main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Crashlytics.init();
    Environment.newInstance(BuildType.dev).run();
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
