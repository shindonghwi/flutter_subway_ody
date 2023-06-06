import 'package:flutter/material.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/theme.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SnackBarUtil {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: getColorScheme(context).colorPrimary,
        content: Text(
          message,
          style: getTextTheme(context).medium.copyWith(
            color: getColorScheme(context).light,
          ),
        ),
      ),
    );
  }
}
