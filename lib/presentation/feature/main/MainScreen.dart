import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/domain/usecases/local/GetIntroPopUpShowingUseCase.dart';
import 'package:subway_ody/domain/usecases/local/PatchIntroPopUpShowingUseCase.dart';
import 'package:subway_ody/firebase/Analytics.dart';
import 'package:subway_ody/presentation/components/CircleLoading.dart';
import 'package:subway_ody/presentation/components/ad/KakaoAdFitBanner.dart';
import 'package:subway_ody/presentation/components/popup/PopupUtil.dart';
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
import 'package:subway_ody/presentation/utils/LifecycleWatcher.dart';

class MainScreen extends HookConsumerWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(mainUiStateProvider);
    final uiStateRead = ref.read(mainUiStateProvider.notifier);
    final currentRegionRead = ref.read(currentRegionProvider.notifier);
    final floatingButtonState = useState<bool>(false);

    final adCount = useState<int>(0);
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
            floatingButtonState.value = true;
          },
          failure: (event) async {
            mainIntentData.value = null;
            debugPrint('failure ${event.errorMessage}');
            floatingButtonState.value = event.errorMessage == ErrorType.not_available.name;
          },
          loading: (_) async {
            floatingButtonState.value = false;
          },
        )?.whenComplete(() {
          adCount.value = 0;
          currentRegionRead.setRegion(uiStateRead.userRegion);
        });
      });
    }, [uiState]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (await GetIt.instance<GetIntroPopUpShowingUseCase>().call()) {
          await GetIt.instance<PatchIntroPopUpShowingUseCase>().call(false);
          PopupUtil.showIntro(backgroundTouchCloseFlag: true);
        }
      });
    }, []);

    return LifecycleWatcher(
      onLifeCycleChanged: (state) {
        if (state == AppLifecycleState.resumed) {
          Analytics.eventManualRefresh();
          uiStateRead.getSubwayData(context, null);
        }
      },
      child: Scaffold(
        appBar: const MainAppBar(),
        backgroundColor: getColorScheme(context).light,
        body: Column(
          children: [
            if (Platform.isAndroid) const KakaoAdFitBanner(),
            Expanded(
              child: Stack(
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
            ),
          ],
        ),
        floatingActionButton: floatingButtonState.value
            ? FloatingActionButton(
                backgroundColor: getColorScheme(context).colorPrimary,
                onPressed: () {
                  Analytics.eventManualRefresh();
                  uiStateRead.getSubwayData(context, null);
                },
                child: SvgPicture.asset('assets/imgs/refresh.svg'))
            : const SizedBox(),
      ),
    );
  }
}
