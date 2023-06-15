import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/usecases/local/GetUserDistanceUseCase.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class CustomSlider extends HookWidget {
  Function(int) onSliderChanged;

  CustomSlider({
    Key? key,
    required this.onSliderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const sliderMin = 0.0;
    const sliderMax = 100.0;
    const distanceMin = 300;
    const distanceMax = 2000;

    // slider value to distance
    int calculateSliderDistance(int value) {
      final distance =
          ((distanceMax - distanceMin) * (value - sliderMin) / (sliderMax - sliderMin)) +
              distanceMin;

      return distance.round();
    }

    // distance to slider value
    int calculateSliderValue(int distance) {
      final value = ((distance - distanceMin) *
              (sliderMax - sliderMin) /
              (distanceMax - distanceMin)) +
          sliderMin;
      return value.round();
    }

    final ValueNotifier<double> sliderValue =
        useState(calculateSliderValue(500).toDouble());

    useEffect(() {
      GetIt.instance<GetUserDistanceUseCase>().call().then((value) {
        debugPrint("value1: $value");
        sliderValue.value = value == null
            ? calculateSliderValue(500).toDouble()
            : calculateSliderValue(value).toDouble();
      });
    }, []);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getAppLocalizations(context).setDistanceRange,
            style: getTextTheme(context).bold.copyWith(
                  color: const Color(0xFF2F2F2F),
                  fontSize: 16,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),
          SliderTheme(
            data: SliderThemeData(
              overlayShape: SliderComponentShape.noOverlay,
              activeTrackColor: getColorScheme(context).colorPrimary,
              activeTickMarkColor: getColorScheme(context).colorPrimary,
              thumbColor: getColorScheme(context).white,
              trackHeight: 8,
              trackShape: _SliderCustomTrackShape(),
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 13,
              ),
              inactiveTrackColor: const Color(0xFFF5F5F5),
            ),
            child: Slider(
              value: sliderValue.value,
              min: sliderMin,
              max: sliderMax,
              onChanged: (double newValue) {
                sliderValue.value = newValue;
                onSliderChanged(calculateSliderDistance(newValue.round()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "300m",
                  style: getTextTheme(context).medium.copyWith(
                        color: const Color(0xFF7C7C7C),
                        fontSize: 14,
                      ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "2km",
                  style: getTextTheme(context).medium.copyWith(
                        color: const Color(0xFF7C7C7C),
                        fontSize: 14,
                      ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderCustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect(
      {required RenderBox parentBox,
      Offset offset = Offset.zero,
      required SliderThemeData sliderTheme,
      bool isEnabled = false,
      bool isDiscrete = false}) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
