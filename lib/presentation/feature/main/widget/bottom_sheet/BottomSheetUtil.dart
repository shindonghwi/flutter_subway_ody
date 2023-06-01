import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/usecases/local/PostSaveUserDistanceUseCase.dart';
import 'package:subway_ody/presentation/feature/main/widget/CustomSlider.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class BottomSheetUtil {
  static void showDistanceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        var currentDistance = 0;

        return SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _appbar(
                    context,
                    () {
                      GetIt.instance<PostSaveUserDistanceUseCase>().call(
                        currentDistance,
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSlider(onSliderChanged: (value) => currentDistance = value),
                        _distanceDescription(context),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
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
            "범위 조절을 통해 거리 영역을 설정할 수 있습니다",
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

  static Row _appbar(BuildContext context, VoidCallback onComplete) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buttonText(context, () => Navigator.pop(context), true),
        Text(
          "거리 설정",
          style: getTextTheme(context).bold.copyWith(
                color: const Color(0xFF2F2F2F),
                fontSize: 16,
              ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        _buttonText(context, () {
          onComplete();
          Navigator.pop(context);
        }, false),
      ],
    );
  }

  static Widget _buttonText(BuildContext context, Function() onTap, bool isCanceled) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Text(
            isCanceled ? "취소" : "확인",
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
