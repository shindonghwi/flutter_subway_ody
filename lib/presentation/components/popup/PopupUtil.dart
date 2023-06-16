import 'package:flutter/material.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/presentation/components/popup/widget/PopUpHiddenMenu.dart';
import 'package:subway_ody/presentation/components/popup/widget/PopUpIntro.dart';

class PopupUtil {
  static void showIntro({required bool backgroundTouchCloseFlag}) {
    final context = SubwayOdyApp.navigatorKey.currentContext as BuildContext;
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        barrierDismissible: backgroundTouchCloseFlag, // Whether to close when touching the outside area
        builder: (BuildContext context) {
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: const AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    content: PopUpIntro(),
                    backgroundColor: Color(0xFFFDFDFD),
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }

  static void showHiddenMenu({required bool backgroundTouchCloseFlag}) {
    final context = SubwayOdyApp.navigatorKey.currentContext as BuildContext;
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        barrierDismissible: backgroundTouchCloseFlag, // Whether to close when touching the outside area
        builder: (BuildContext context) {
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: const AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    content: PopUpHiddenMenu(),
                    backgroundColor: Color(0xFFFDFDFD),
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }


  static void close(){
    final context = SubwayOdyApp.navigatorKey.currentContext as BuildContext;
    Navigator.pop(context);
  }
}
