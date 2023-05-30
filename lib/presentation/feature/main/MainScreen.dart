import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/domain/usecases/local/GetLatLngUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetLocationPermissionUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetKakaoLatlngToRegionUseCase.dart';
import 'package:subway_ody/presentation/feature/main/widget/MainAppBar.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ActiveContent.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ErrorGpsContent.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ErrorNotAvailableContent.dart';
import 'package:subway_ody/presentation/feature/provider/CurrentRegionNotifier.dart';
import 'package:subway_ody/presentation/feature/provider/MainUiState.dart';
import 'package:subway_ody/presentation/models/UiState.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

enum ErrorType { gps_error, not_available }

class MainScreen extends HookConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(mainUiStateProvider);
    final uiStateRead = ref.read(mainUiStateProvider.notifier);
    final currentRegionRead = ref.read(currentRegionProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        var latlng;
        var permissionGranted = false;

        uiStateRead.changeUiState(Loading());

        await GetIt.instance<GetLocationPermissionUseCase>().call().then((value) {
          if (!value) {
            uiStateRead.changeUiState(Failure(ErrorType.gps_error.name));
          }
          permissionGranted = value;
        });

        if (permissionGranted) {
          await GetIt.instance<GetLatLngCallUseCase>().call().then((gps) {
            // gps null or 0.0 check code write
            if (gps.latitude == null || gps.longitude == null) {
              uiStateRead.changeUiState(Failure(ErrorType.gps_error.name));
            }
            latlng = gps;
          });

          if (latlng != null) {
            await GetIt.instance<GetKakaoLatlngToRegionUseCase>()
                .call(latlng)
                .then((value) {
              currentRegionRead.setRegion(
                value.documents?.first.address_name ?? "지역 정보 없음",
              );

              if (value.documents != null) {
                uiStateRead.changeUiState(Success(null));
              } else {
                uiStateRead.changeUiState(Failure(ErrorType.not_available.name));
              }
            });
          }
        }
      });
    }, []);

    return Scaffold(
      appBar: const MainAppBar(),
      body: uiState is Success
          ? const ActiveContent()
          : uiState is Failure<String>
              ? uiState.errorMessage == ErrorType.gps_error.name
                  ? const ErrorGpsContent()
                  : const ErrorNotAvailableContent()
              : Center(
                  child: CircularProgressIndicator(
                    color: getColorScheme(context).colorPrimary,
                  ),
                ),
      floatingActionButton: uiState is Success
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
