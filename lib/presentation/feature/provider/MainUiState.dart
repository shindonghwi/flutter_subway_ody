import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/domain/usecases/local/GetLatLngUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetLocationPermissionUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetKakaoLatlngToRegionUseCase.dart';
import 'package:subway_ody/presentation/feature/main/MainIntent.dart';
import 'package:subway_ody/presentation/models/UiState.dart';

enum ErrorType { gps_error, not_available }

final mainUiStateProvider =
    StateNotifierProvider<MainUiStateNotifier, UIState<MainIntent>>(
  (_) => MainUiStateNotifier(),
);

class MainUiStateNotifier extends StateNotifier<UIState<MainIntent>> {
  MainUiStateNotifier() : super(Loading());

  GetLocationPermissionUseCase get _getLocationPermission =>
      GetIt.instance<GetLocationPermissionUseCase>();

  GetLatLngCallUseCase get _getLatLng => GetIt.instance<GetLatLngCallUseCase>();

  GetKakaoLatlngToRegionUseCase get _getKakaoLatLngToRegion =>
      GetIt.instance<GetKakaoLatlngToRegionUseCase>();

  void _changeUiState(UIState<MainIntent> s) => state = s;

  /// 지하철 정보 요청 API 호출
  getSubwayData() async {
    _changeUiState(Loading());

    _getLocationPermission.call().then((value) {
      // 위치 권한 체크
      if (!value) {
        _changeUiState(Failure(ErrorType.gps_error.name));
      } else {
        _getLatLng.call().then((gps) {
          // 현재 위치 가져오기
          if (gps.latitude == null || gps.longitude == null) {
            _changeUiState(Failure(ErrorType.gps_error.name));
          } else {
            _getKakaoLatLngToRegion.call(gps).then((value) {
              // 현재 위치를 주소로 변환
              if (value.status == 200) {

                final regionAddress = [
                  value.data?.documents?.first.address?.region_3depth_name ?? "",
                  value.data?.documents?.first.road_address?.road_name ?? ""
                ];
                
                final isAllEmptyOrNull = regionAddress.every((text) => text.isEmpty);

                _changeUiState(
                  Success(
                    MainIntent(
                      region: isAllEmptyOrNull
                          ? "지역 정보 없음"
                          : regionAddress.join(" ")
                    ),
                  ),
                );
              } else {
                _changeUiState(Failure(ErrorType.not_available.name));
              }
            });
          }
        });
      }
    }).catchError((e) {
      _changeUiState(Failure(e.toString()));
    });
  }
}
