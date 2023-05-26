import 'package:flutter/material.dart';
import 'package:subway_ody/app/env/Environment.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.newInstance(BuildType.prod).run();
}
