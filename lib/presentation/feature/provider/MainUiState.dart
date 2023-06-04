import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/domain/models/remote/subway/SubwayRealTimeArrival.dart';
import 'package:subway_ody/domain/models/remote/subway/SubwayResponse.dart';
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
import 'package:subway_ody/presentation/utils/CollectionUtil.dart';
import 'package:subway_ody/presentation/utils/SubwayUtil.dart';
import 'package:subway_ody/presentation/utils/dto/Pair.dart';

enum ErrorType { gps_error, not_available }

final mainUiStateProvider =
    StateNotifierProvider<MainUiStateNotifier, UIState<MainIntent>>(
  (_) => MainUiStateNotifier(),
);

class MainUiStateNotifier extends StateNotifier<UIState<MainIntent>> {
  MainUiStateNotifier() : super(Loading());

  LatLng? latLng;

  void _changeUiState(UIState<MainIntent> s) => state = s;

  /// 지하철 정보 요청 API 호출
  getSubwayData(BuildContext context, int? distance) async {
    _changeUiState(Loading());

    List<SubwayModel> subwayDataList = [];

    final isPermissionGranted = await _checkLocationPermission();

    if (isPermissionGranted) {
      await _requestLatLng();

      if (latLng == null) {
        _changeUiState(Failure(ErrorType.gps_error.name));
      } else {
        List<String>? addressList = await _requestLatLngToRegion();
        List<NearByStation>? nearByStationList = await _requestNearByStation(distance);

        if (!CollectionUtil.isNullorEmpty(addressList) &&
            !CollectionUtil.isNullorEmpty(nearByStationList)) {
          final List<Pair<NearByStation, SubwayResponse>> arrivalInfoList = [];
          for (var element in nearByStationList!) {
            final arrivalRes = await GetIt.instance<GetSubwayArrivalUseCase>().call(
              element.subwayName,
            );
            debugPrint('element: ${element.subwayLine}');
            debugPrint('element: ${element.subwayName}');

            if (arrivalRes.status == 200) {
              arrivalInfoList.add(Pair(element, arrivalRes.data!));
            }
          }

          if (arrivalInfoList.isNotEmpty) {
            for (var index = 0; index < arrivalInfoList.length; index++) {
              var arrivalInfo = arrivalInfoList[index];

              debugPrint('arrivalInfo: ${arrivalInfo.first.subwayLine}');
              debugPrint('arrivalInfo: ${arrivalInfo.first.subwayName}');

              // 지하철 번호로 그룹화 하고, 상/하행 으로 다시 그룹화한 리스트
              List<SubwayRealTimeArrival> subwayArrivalList =
                  arrivalInfo.second.realtimeArrivalList!;

              var groupedBySubwayId =
                  groupBy(subwayArrivalList, (arrival) => arrival.subwayId);

              groupedBySubwayId.forEach((subwayId, arrivalsBySubwayId) {
                var groupedByUpdnLine =
                    groupBy(arrivalsBySubwayId, (arrival) => arrival.updnLine);

                List<SubwayDirectionStationModel> stationModelList = [];

                groupedByUpdnLine.forEach((updnLine, arrivalsByUpdnLine) {
                  // 지하철역명 리스트는 첫번쨰 기준으로만 뽑으면됨.
                  final subwayNameList = SubwayUtil.findSubwayNameList(
                    subwayId: subwayId,
                    currentSubwayId: arrivalsByUpdnLine.first.statnId,
                    preSubwayId: arrivalsByUpdnLine.first.statnFid,
                    nextSubwayId: arrivalsByUpdnLine.first.statnTid,
                    isUp: arrivalsByUpdnLine.first.ordkey.startsWith("0"),
                  );

                  final List<int> subwayPositionList = [];

                  for (var arrival in arrivalsByUpdnLine) {
                    final subwayIndex = subwayNameList.indexOf(arrival.arvlMsg3) == 0
                        ? 0
                        : !subwayNameList.contains(arrival.arvlMsg3)
                            ? -1
                            : (subwayNameList.indexOf(arrival.arvlMsg3) * 2) +
                                (arrival.arvlCd == "99"
                                    ? (arrival.ordkey.startsWith("0") ? 1 : -1)
                                    : 0);

                    subwayPositionList.add(subwayIndex);

                    debugPrint('subwayId: $subwayId '
                        'updnLine: ${updnLine} '
                        'ordkey: ${arrival.ordkey} '
                        'stainId: ${arrival.statnId} '
                        'statnNm: ${arrival.statnNm} '
                        'arvlMsg2: ${arrival.arvlMsg2} '
                        'trainLineNm: ${arrival.trainLineNm}'
                        ' arvlMsg3: ${arrival.arvlMsg3}'
                        ' arvlCd: ${arrival.arvlCd}'
                        ' subwayNameList: $subwayNameList'
                        ' findIndex: ${subwayNameList.indexOf(arrival.arvlMsg3)}'
                        ' subwayPositionList: ${subwayPositionList}');
                  }
                  debugPrint("--------------------------");

                  stationModelList.add(SubwayDirectionStationModel(
                    subwayNameList: subwayNameList,
                    destination: arrivalsByUpdnLine.first.trainLineNm
                        .split("-")
                        .first
                        .trim()
                        .toString(),
                    nextStation: arrivalsByUpdnLine.first.trainLineNm
                        .split("-")
                        .last
                        .trim()
                        .toString(),
                    subwayPositionList: subwayPositionList,
                    updnLine: arrivalsByUpdnLine.first.updnLine,
                    arvlMsg3: arrivalsByUpdnLine.first.arvlMsg3,
                    arvlMsg2: arrivalsByUpdnLine.first.arvlMsg2,
                    arvlCd: arrivalsByUpdnLine.first.arvlCd,
                    ordkey: arrivalsByUpdnLine.first.ordkey,
                  ));
                });

                subwayDataList.add(
                  SubwayModel(
                    subwayId: subwayId,
                    subwayName: arrivalInfo.first.subwayName,
                    distance: arrivalInfo.first.distance,
                    mainColor: SubwayUtil.getMainColor(context, subwayId.toString()),
                    stationInfoList: stationModelList,
                  ),
                );
              });
            }
            _changeUiState(
              Success(
                MainIntent(
                  userRegion: addressList!.join(" "),
                  subwayItems: subwayDataList,
                ),
              ),
            );
          } else {
            debugPrint("arrivalInfoList is empty");
            _changeUiState(Failure(ErrorType.not_available.name));
          }
        } else {
          debugPrint("addressList or nearByStationList is empty");
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
  Future<List<String>?> _requestLatLngToRegion() async {
    List<String> addressList = [];
    debugPrint("_requestLatLngToRegion latLng : $latLng");
    if (latLng == null) return Future(() => null);
    final response = await GetIt.instance<GetKakaoLatLngToRegionUseCase>().call(latLng!);

    if (response.status == 200) {
      String? address1 = response.data?.documents?.first.address?.region_3depth_name;
      String? address2 = response.data?.documents?.first.road_address?.road_name;
      address1 != null ? addressList.add(address1) : null;
      address2 != null ? addressList.add(address2) : null;
    }

    return addressList;
  }

  /// 현재 위치에서 가장 가까운 지하철역 정보 가져오기
  Future<List<NearByStation>?> _requestNearByStation(int? distance) async {
    List<NearByStation> nearByStationList = [];

    debugPrint("_requestNearByStation latLng : $latLng");
    if (latLng == null) return Future(() => null);

    final tempDistance =
        distance ?? await GetIt.instance<GetUserDistanceUseCase>().call();

    final stationInfo = await GetIt.instance<GetNearBySubwayStationUseCase>().call(
      latLng!,
      tempDistance,
    );

    stationInfo.data?.documents?.forEach((element) {
      final sn = element.place_name.split(" ").first;
      final sl = element.place_name.split(" ").last;
      final findSn = SubwayUtil.findSubwayName(subwayName: sn, subwayLine: sl);

      nearByStationList.add(NearByStation(
          subwayName: findSn,
          subwayLine: element.place_name.split(" ").last,
          distance: element.distance));
    });

    return nearByStationList;
  }
}
