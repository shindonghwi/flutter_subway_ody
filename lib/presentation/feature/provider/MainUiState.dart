import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/domain/usecases/local/GetLatLngUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetLocationPermissionUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetKakaoLatLngToRegionUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetNearBySubwayStationUseCase.dart';
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

  GetKakaoLatLngToRegionUseCase get _getKakaoLatLngToRegion =>
      GetIt.instance<GetKakaoLatLngToRegionUseCase>();

  GetNearBySubwayStationUseCase get _getNearBySubwayStation =>
      GetIt.instance<GetNearBySubwayStationUseCase>();

  static String subwayLine = "";
  static List<String> addressList = [];

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
            _getNearBySubwayStation.call(gps, 500).then((value) {
              subwayLine = value.data?.documents?.first.place_name.split(" ").last ?? "";
              if (subwayLine.isNotEmpty && addressList.isNotEmpty) {
                getSubwayInfo();
              }
            }).catchError((e) {
              _changeUiState(Failure(e.toString()));
            });

            _getKakaoLatLngToRegion.call(gps).then((value) {
              // 현재 위치를 주소로 변환
              if (value.status == 200) {
                String? address1 =
                    value.data?.documents?.first.address?.region_3depth_name;
                String? address2 = value.data?.documents?.first.road_address?.road_name;

                address1 != null ? addressList.add(address1) : null;
                address2 != null ? addressList.add(address2) : null;

                if (subwayLine.isNotEmpty && addressList.isNotEmpty) {
                  getSubwayInfo();
                }
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

  getSubwayInfo() {
    _changeUiState(Success(MainIntent(region: addressList.join(" "))));
  }
}
