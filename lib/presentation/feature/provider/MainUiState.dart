import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/domain/models/remote/subway/SubwayRealTimeArrival.dart';
import 'package:subway_ody/domain/usecases/local/GetLatLngUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetLocationPermissionUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetUserDistanceUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetKakaoLatLngToRegionUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetNearBySubwayStationUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetSubwayArrivalUseCase.dart';
import 'package:subway_ody/presentation/feature/main/MainIntent.dart';
import 'package:subway_ody/presentation/feature/main/models/NearByStation.dart';
import 'package:subway_ody/presentation/feature/main/models/SubwayModel.dart';
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
  static List<SubwayRealTimeArrival> subwayArrivalList = [];
  static List<SubwayModel> subwayDataList = [];

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
          for (var element in nearByStationList) {
            final arrivalInfo = await GetIt.instance<GetSubwayArrivalUseCase>().call(
              element.subwayName,
            );

            if (arrivalInfo.data?.realtimeArrivalList != null) {
              subwayDataList.add(
                SubwayModel(
                  nearByStation: element,
                  subwayArrivalList: arrivalInfo.data!.realtimeArrivalList!,
                ),
              );
            }
            // /// 1001:1호선 1002:2호선 1003:3호선, 1004:4호선,1005:5호선, 1006:6호선,1007:7호선, 1008:8호선, 1009:9호선,
            // /// 1061:중앙선 1063:경의중앙선, 1065:공항철도, 1067:경춘선, 1075:수의분당선 1077:신분당선, 1092:우이신설선
            // final String subwayId; //
            //
            // final String updnLine; // 0: 상행/내선, 1: 하행/외선
            // final String trainLineNm; // 성수행(목적지역) - 구로디지털단지방면(다음역)
            // final String statnNm; // 지하철 역 명 (예: 홍대입구)
            // final String btrainSttus; // 급행, ITX, 일반
            // final String arvlMsg2; // 첫번째 도착 메새지
            debugPrint("$element arrivalInfo : $arrivalInfo");
          }
          _changeUiState(
            Success(
              MainIntent(userRegion: addressList.join(" "), subwayItems: subwayDataList),
            ),
          );
        } else {
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
    int distance = await GetIt.instance<GetUserDistanceUseCase>().call();
    final stationInfo = await GetIt.instance<GetNearBySubwayStationUseCase>().call(
      latLng!,
      distance,
    );

    stationInfo.data?.documents?.forEach((element) {
      nearByStationList.add(NearByStation(
          subwayName: element.place_name.split(" ").first,
          subwayLine: element.place_name.split(" ").last,
          distance: element.distance));
    });
    nearByStationList.forEach((element) {
      debugPrint(
          "nearByStationList data : ${element.subwayName} ${element.subwayLine} ${element.distance}");
    });
  }
}
