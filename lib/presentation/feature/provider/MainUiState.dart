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
          for (var element in nearByStationList!) {
            List<SubwayDirectionStationModel> stationModelList = [];
            final subwayName = element.subwayName;
            final subwayLine = element.subwayLine;
            final distance = element.distance;

            final arrivalRes = await GetIt.instance<GetSubwayArrivalUseCase>().call(
              subwayName,
            );

            if (arrivalRes.status == 200) {
              var arrivalInfo = arrivalRes.data;

              List<SubwayRealTimeArrival>? subwayArrivalList =
                  arrivalInfo?.realtimeArrivalList!;

              // 근처 지하철 id를 찾았는데, 실시간 지하철 목록과 비교하여 같은 호선만 찾는다.
              var groupedBySubwayId =
                  groupBy(subwayArrivalList!, (arrival) => arrival.subwayId);
              List<String> subwayIdList = [];
              for (var subwayIdGroupData in groupedBySubwayId.entries) {
                String subwayId = subwayIdGroupData.key;
                if (subwayId != SubwayUtil.subwayLineToId(subwayLine)) {
                  continue;
                } else {
                  subwayIdList.add(subwayId);
                }
              }

              var resultMap = <String, Pair<SubwayRealTimeArrival, List<String>>>{};
              subwayIdList.forEach((element) {
                groupedBySubwayId.entries.forEach((groupData) {
                  var groupedByUpdnLine =
                      groupBy(groupData.value, (arrival) => arrival.updnLine);
                  for (var upDownLineMap in groupedByUpdnLine.entries) {
                    // 상행 리스트 또는 하행 리스트
                    final isUp = upDownLineMap.key;
                    // 지하철 이름별로 묶기
                    var groupedByStatnNm =
                        groupBy(upDownLineMap.value, (arrival) => arrival.statnNm);
                    groupedByStatnNm.forEach((key, value) {
                      var firstValue = value.first;
                      var nameList = SubwayUtil.findSubwayNameList(
                        subwayId: firstValue.subwayId,
                        currentStatnId: firstValue.statnId,
                        preStatnId: firstValue.statnFid,
                        nextStatnId: firstValue.statnTid,
                        isUp: firstValue.ordkey.startsWith("0"),
                      );
                      resultMap["$key||$isUp"] = Pair(firstValue, nameList);
                    });
                  }
                });
              });

              for (var element in resultMap.entries) {
                final nameKey = element.key; // 군자(능동)||상행
                final data = element.value.first; // 지하철 실시간 도착 정보
                final nameList = element.value.second; // 지하철 역 리스트 정보

                final List<int> subwayPositionList = [];

                for (var arrival in subwayArrivalList) {
                  final subwayIndex = nameList.indexOf(arrival.arvlMsg3) == 0
                      ? 0
                      : !nameList.contains(arrival.arvlMsg3)
                          ? -1
                          : (nameList.indexOf(arrival.arvlMsg3) * 2) +
                              (arrival.arvlCd == "99"
                                  ? (arrival.ordkey.startsWith("0") ? 1 : -1)
                                  : 0);
                  subwayPositionList.add(subwayIndex);
                }

                stationModelList.add(SubwayDirectionStationModel(
                  subwayNameList: nameList,
                  destination: data.trainLineNm.split("-").first.trim().toString(),
                  nextStation: data.trainLineNm.split("-").last.trim().toString(),
                  btrainSttus: data.btrainSttus.split("-").last.trim().toString(),
                  subwayPositionList: subwayPositionList,
                  updnLine: data.updnLine,
                  arvlMsg3: data.arvlMsg3,
                  arvlMsg2: data.arvlMsg2,
                  arvlCd: data.arvlCd,
                  ordkey: data.ordkey,
                ));
              }
            }
            subwayDataList.add(
              SubwayModel(
                subwayLine: subwayLine,
                subwayName: subwayName,
                distance: distance,
                mainColor: SubwayUtil.getMainColor(context, subwayLine),
                stationInfoList: stationModelList,
              ),
            );
          }

          if (!CollectionUtil.isNullorEmpty(subwayDataList)) {
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

    debugPrint("_requestNearByStation nearByStationList : $nearByStationList");

    return nearByStationList;
  }
}
