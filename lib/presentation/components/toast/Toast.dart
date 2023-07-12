import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class ToastUtil {
  static void errorToast(String message) async {
    if (message.isNotEmpty) {
      OverlayEntry overlay = OverlayEntry(builder: (_) => Toast(type: ToastType.Error, message: message));
      final context = SubwayOdyApp.navigatorKey.currentContext as BuildContext;
      Navigator.of(context).overlay?.insert(overlay);
    }
  }

  static void defaultToast(String message) async {
    if (message.isNotEmpty) {
      OverlayEntry overlay = OverlayEntry(builder: (_) => Toast(type: ToastType.Default, message: message));
      final context = SubwayOdyApp.navigatorKey.currentContext as BuildContext;
      Navigator.of(context).overlay?.insert(overlay);
    }
  }
}

enum ToastType { Default, Error }

class Toast extends StatefulWidget {
  final ToastType type;
  final String message;

  const Toast({
    Key? key,
    required this.type,
    required this.message,
  }) : super(key: key);

  @override
  _ToastState createState() => _ToastState();
}

class _ToastState extends State<Toast> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = TweenSequence<Offset>([
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(begin: const Offset(0.0, -0.2), end: const Offset(0.0, 0.5)),
        weight: 1,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(begin: const Offset(0.0, 0.5), end: const Offset(0.0, 0.7))
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 3,
      ),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _startFadeOutAnimation();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _startFadeOutAnimation() async {
    await Future.delayed(const Duration(seconds: 3));
    await _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: getMediaQuery(context).size.width * 0.9,
                height: 60,
                decoration: BoxDecoration(
                  color: widget.type == ToastType.Default
                      ? getColorScheme(context).neutral80
                      : getColorScheme(context).colorError,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.type == ToastType.Error)
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SvgPicture.asset(
                          "assets/imgs/icon_information.svg",
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      ),
                    Text(
                      widget.message.toString(),
                      style: getTextTheme(context).medium.copyWith(color: Colors.white, height: 1.44),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
