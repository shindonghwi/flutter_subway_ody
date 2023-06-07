import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/presentation/components/CircleLoading.dart';
import 'package:subway_ody/presentation/feature/main/MainIntent.dart';
import 'package:subway_ody/presentation/feature/main/widget/MainAppBar.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ActiveContent.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/Error500Content.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ErrorGpsContent.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ErrorNotAvailableContent.dart';
import 'package:subway_ody/presentation/feature/provider/CurrentRegionNotifier.dart';
import 'package:subway_ody/presentation/feature/provider/MainUiState.dart';
import 'package:subway_ody/presentation/models/UiState.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/SnackBarUtil.dart';
import 'package:subway_ody/presentation/utils/Throttler.dart';

Throttler throttler = Throttler(milliseconds: 5000);

class MainScreen extends HookConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(mainUiStateProvider);
    final uiStateRead = ref.read(mainUiStateProvider.notifier);
    final currentRegionRead = ref.read(currentRegionProvider.notifier);

    final mainIntentData = useState<MainIntent?>(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        uiStateRead.getSubwayData(context, null);
      });
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        uiState.when(
          success: (event) async {
            mainIntentData.value = event.value;
            currentRegionRead.setRegion(event.value.userRegion);
          },
          failure: (event) async {
            mainIntentData.value = null;
            debugPrint('failure ${event.errorMessage}');
          },
        );
      });
    }, [uiState]);

    return Scaffold(
      appBar: const MainAppBar(),
      backgroundColor: getColorScheme(context).light,
      body: Stack(
        children: [
          mainIntentData.value == null
              ? uiState is Success<MainIntent>
                  ? ActiveContent(subwayModel: uiState.value)
                  : const SizedBox()
              : ActiveContent(subwayModel: mainIntentData.value!),
          if (uiState is Failure<MainIntent>)
            uiState.errorMessage == ErrorType.gps_error.name
                ? const ErrorGpsContent()
                : uiState.errorMessage == ErrorType.not_available.name
                    ? const ErrorNotAvailableContent()
                    : const Error500Content(),
          if (uiState is Loading) const CircleLoading(),
        ],
      ),
      floatingActionButton: (uiState is Success)
          ? FloatingActionButton(
              backgroundColor: getColorScheme(context).colorPrimary,
              onPressed: () {
                throttler.run(() {
                  uiStateRead.getSubwayData(context, null);
                }, callback: (remainTime) {
                  SnackBarUtil.show(
                      context,
                      getAppLocalizations(context).message_remain_time(
                        5 - remainTime,
                      ));
                });
              },
              child: SvgPicture.asset('assets/imgs/refresh.svg'))
          : const SizedBox(),
    );
  }
}
