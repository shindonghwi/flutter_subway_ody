import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/domain/models/LatLng.dart';
import 'package:subway_ody/domain/usecases/local/GetLatLngUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetLocationPermissionUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetKakaoLatLngToRegionUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetNearBySubwayStationUseCase.dart';
import 'package:subway_ody/presentation/feature/main/MainIntent.dart';
import 'package:subway_ody/presentation/feature/main/models/NearByStation.dart';
import 'package:subway_ody/presentation/models/UiState.dart';

enum ErrorType { gps_error, not_available }

final mainUiStateProvider =
    StateNotifierProvider<MainUiStateNotifier, UIState<MainIntent>>(
  (_) => MainUiStateNotifier(),
);

class MainUiStateNotifier extends StateNotifier<UIState<MainIntent>> {
  MainUiStateNotifier() : super(Loading());


  static List<NearByStation> nearByStationList = [];
  static LatLng? latLng;
  static List<String> addressList = [];

  void _changeUiState(UIState<MainIntent> s) => state = s;

  /// 지하철 정보 요청 API 호출
  getSubwayData() async {
    _changeUiState(Loading());

    final isPermissionGranted = await _checkLocationPermission();

    if (isPermissionGranted) {
      await _requestLatLng();

      if (latLng == null) {
        _changeUiState(Failure(ErrorType.gps_error.name));
      } else {
        await _requestLatLngToRegion();
        await _requestNearByStation();
        if (addressList.isNotEmpty && nearByStationList.isNotEmpty) {
          _changeUiState(Success(MainIntent(region: addressList.join(" "))));
        }else{
          _changeUiState(Failure(ErrorType.not_available.name));
        }
      }
    } else {
      _changeUiState(Failure(ErrorType.gps_error.name));
    }
  }


  /// 위치 권한 체크
  _checkLocationPermission() async {
    return await GetIt.instance<GetLocationPermissionUseCase>().call();
  }

  /// 현재 위치 가져오기
  _requestLatLng() async {
    final gpsInfo = await GetIt.instance<GetLatLngCallUseCase>().call();
    if (gpsInfo.latitude != null && gpsInfo.longitude != null) {
      latLng = gpsInfo;
    }
  }

  /// 현재 위치를 주소로 변환
  _requestLatLngToRegion() async {
    debugPrint("_requestLatLngToRegion latLng : $latLng");
    if (latLng == null) return;
    final response = await GetIt.instance<GetKakaoLatLngToRegionUseCase>().call(latLng!);

    if (response.status == 200) {
      String? address1 = response.data?.documents?.first.address?.region_3depth_name;
      String? address2 = response.data?.documents?.first.road_address?.road_name;
      address1 != null ? addressList.add(address1) : null;
      address2 != null ? addressList.add(address2) : null;
    }
  }

  /// 현재 위치에서 가장 가까운 지하철역 정보 가져오기
  _requestNearByStation() async {
    debugPrint("_requestNearByStation latLng : $latLng");
    if (latLng == null) return;
    final stationInfo = await GetIt.instance<GetNearBySubwayStationUseCase>().call(latLng!, 500);

    stationInfo.data?.documents?.forEach((element) {
      nearByStationList.add(
          NearByStation(
            subwayName: element.place_name.split(" ").first,
            subwayLine: element.place_name.split(" ").last,
          )
      );
    });
  }
}
