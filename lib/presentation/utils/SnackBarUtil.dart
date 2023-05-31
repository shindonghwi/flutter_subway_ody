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
        content: Text(
          message,
          style: getTextTheme(context).medium.copyWith(
            color: ThemeMode.system == ThemeMode.light
                ? AppTheme.darkTheme.colorScheme.white
                : AppTheme.lightTheme.colorScheme.black,
          ),
        ),
      ),
    );
  }
}
