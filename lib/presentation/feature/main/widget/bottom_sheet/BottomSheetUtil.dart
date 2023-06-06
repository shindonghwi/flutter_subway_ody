import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/domain/usecases/local/PostSaveUserDistanceUseCase.dart';
import 'package:subway_ody/presentation/feature/main/widget/CustomSlider.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class BottomSheetUtil {
  static void showDistanceBottomSheet(
    BuildContext context, {
    required Function(int) onComplete,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: getColorScheme(context).light,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) => HookBuilder(builder: (BuildContext context) {
        final currentDistance = useState(0);
        return SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DistanceSettingAppBar(
                    distance: currentDistance.value == 0 ? 800 : currentDistance.value,
                    onComplete: onComplete,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSlider(onSliderChanged: (value) {
                          debugPrint("value: $value");
                          currentDistance.value = value;
                        }),
                        _distanceDescription(context),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
      // builder: HookBuilder(builder: builder)
    );
  }

  static Container _distanceDescription(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/imgs/radar.svg',
            width: 17,
            height: 17,
            colorFilter: const ColorFilter.mode(Color(0xFF7C7C7C), BlendMode.srcIn),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            getAppLocalizations(context).setDistanceDescription,
            style: getTextTheme(context).regular.copyWith(
                  color: const Color(0xFF7C7C7C),
                  fontSize: 12,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class DistanceSettingAppBar extends HookConsumerWidget {
  final int distance;
  final Function(int) onComplete;

  const DistanceSettingAppBar({
    Key? key,
    required this.distance,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buttonText(context, () => Navigator.pop(context), true),
        Text(
          getAppLocalizations(context).setDistanceTitle,
          style: getTextTheme(context).bold.copyWith(
                color: const Color(0xFF2F2F2F),
                fontSize: 16,
              ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        _buttonText(context, () {
          Navigator.pop(context);
          onComplete.call(distance);
        }, false),
      ],
    );
  }

  Widget _buttonText(BuildContext context, Function() onTap, bool isCanceled) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Text(
            isCanceled
                ? getAppLocalizations(context).common_cancel
                : getAppLocalizations(context).common_confirm,
            style: getTextTheme(context).medium.copyWith(
                  color: isCanceled ? const Color(0xFF7C7C7C) : const Color(0xFF2F2F2F),
                  fontSize: 16,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
