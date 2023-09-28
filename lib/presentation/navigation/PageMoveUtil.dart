import 'package:flutter/material.dart';
import 'package:subway_ody/presentation/navigation/Route.dart';

PageRouteBuilder nextSlideScreen(String route, {dynamic parameter}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, animation, secondaryAnimation) =>
        RoutingScreen.getScreen(route, parameter: parameter),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
            .animate(animation),
        child: child,
      );
    },
  );
}

PageRouteBuilder nextFadeInOutScreen(String route, {dynamic parameter}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 600),
    pageBuilder: (context, animation, secondaryAnimation) =>
        RoutingScreen.getScreen(route, parameter: parameter),
    reverseTransitionDuration: const Duration(milliseconds: 600),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      );
      return FadeTransition(
        opacity: curvedAnimation,
        child: child,
      );
    },
  );
}


PageRoute nextSlideUpScreen(String route, {dynamic parameter, fullScreen = false}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => RoutingScreen.getScreen(route, parameter: parameter),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    fullscreenDialog: fullScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0, 1);
      var end = const Offset(0, 0);
      var curve = Curves.fastOutSlowIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var curvedAnimation = animation.drive(tween);

      return SlideTransition(
        position: curvedAnimation,
        child: child,
      );
    },
  );
}
