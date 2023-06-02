import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/presentation/components/CircleLoading.dart';
import 'package:subway_ody/presentation/feature/main/MainIntent.dart';
import 'package:subway_ody/presentation/feature/main/widget/MainAppBar.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ActiveContent.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ErrorGpsContent.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ErrorNotAvailableContent.dart';
import 'package:subway_ody/presentation/feature/provider/CurrentRegionNotifier.dart';
import 'package:subway_ody/presentation/feature/provider/MainUiState.dart';
import 'package:subway_ody/presentation/models/UiState.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(mainUiStateProvider);
    final uiStateRead = ref.read(mainUiStateProvider.notifier);
    final currentRegionRead = ref.read(currentRegionProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        uiStateRead.getSubwayData(context);
      });
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        uiState.when(
          success: (event) async {
            currentRegionRead.setRegion(event.value.userRegion);
          },
        );
        (uiState is Failure);
      });
    }, [uiState]);

    return Scaffold(
      appBar: const MainAppBar(),
      body: Stack(
        children: [
          if (uiState is Success<MainIntent>)
            ActiveContent(subwayModel: uiState.value),
          if (uiState is Failure<MainIntent>)
            uiState.errorMessage == ErrorType.gps_error.name
                ? const ErrorGpsContent()
                : const ErrorNotAvailableContent(),
          if (uiState is Loading) const CircleLoading()
        ],
      ),
      floatingActionButton: (uiState is Success)
          ? FloatingActionButton(
              backgroundColor: getColorScheme(context).colorPrimary,
              onPressed: () {
                // uiState.value == UiState.SUCCESS ? ;
              },
              child: SvgPicture.asset('assets/imgs/refresh.svg'))
          : const SizedBox(),
    );
  }
}
