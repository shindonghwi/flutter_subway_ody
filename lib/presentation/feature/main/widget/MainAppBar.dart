import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/presentation/feature/main/widget/bottom_sheet/BottomSheetUtil.dart';
import 'package:subway_ody/presentation/feature/provider/CurrentRegionNotifier.dart';
import 'package:subway_ody/presentation/navigation/PageMoveUtil.dart';
import 'package:subway_ody/presentation/navigation/Route.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class MainAppBar extends HookConsumerWidget with PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return AppBar(
      backgroundColor: const Color(0xFFFDFDFD),
      bottomOpacity: 0.0,
      elevation: 1.0,
      shadowColor: const Color(0xFFEDEDED),
      automaticallyImplyLeading: false,
      title: const _RegionText(),
      centerTitle: false,
      actions: [
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.only(right: 0),
            child: InkWell(
              onTap: () => showDistanceEditBottomSheet(context),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(
                  "assets/imgs/distance.svg",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  nextSlideScreen(RoutingScreen.Setting.route),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(
                  "assets/imgs/setting.svg",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);

  showDistanceEditBottomSheet(BuildContext context) =>
      BottomSheetUtil.showDistanceBottomSheet(context);
}

class _RegionText extends HookConsumerWidget {

  const _RegionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final region = ref.watch(currentRegionProvider);

    return Text(
      region,
      style: getTextTheme(context).medium.copyWith(
            color: const Color(0xFF2F2F2F),
            fontSize: 18,
            height: 1.28,
          ),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    );
  }
}
