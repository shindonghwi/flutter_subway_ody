import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
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
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/SubwayUtil.dart';
import 'package:subway_ody/presentation/utils/dto/Pair.dart';

enum ErrorType {
  gps_error,
  not_available,
  error_500,
}

final mainUiStateProvider = StateNotifierProvider<MainUiStateNotifier, UIState<MainIntent>>(
  (_) => MainUiStateNotifier(),
);

class MainUiStateNotifier extends StateNotifier<UIState<MainIntent>> {
  MainUiStateNotifier() : super(Loading());

  LatLng? latLng;
  String userRegion = "";

  void _changeUiState(UIState<MainIntent> s) => state = s;

  /// 지하철 정보 요청 API 호출
  getSubwayData(BuildContext context, int? distance) async {
    debugPrint("getSubwayData");
    _changeUiState(Loading());

    List<SubwayModel> subwayDataList = [];

    final isPermissionGranted = await _checkLocationPermission();

    if (isPermissionGranted) {
      debugPrint("isPermissionGranted: $isPermissionGranted");
      await _requestLatLng();

      if (latLng == null) {
        _changeUiState(Failure(ErrorType.gps_error.name));
      } else {
        List<String>? addressList = await _requestLatLngToRegion();
        _setUserRegion(addressList); // 사용자 위치 설정

        List<NearByStation>? nearByStationList = await _requestNearByStation(distance);

        if (!CollectionUtil.isNullorEmpty(addressList) && !CollectionUtil.isNullorEmpty(nearByStationList)) {
          for (var element in nearByStationList!) {
            final subwayName = element.subwayName;
            final subwayLine = element.subwayLine;

            if (subwayName.isEmpty) {
              continue;
            }

            final distance = element.distance;

            final arrivalRes = await GetIt.instance<GetSubwayArrivalUseCase>().call(
              subwayName,
            );

            if (arrivalRes.status == 200) {
              var arrivalInfo = arrivalRes.data;
              if (CollectionUtil.isNullorEmpty(arrivalInfo?.realtimeArrivalList)) {
                continue;
              }

              final subwayArrivalList = arrivalInfo?.realtimeArrivalList!;

              if (subwayLine.isEmpty) {
                continue;
              }

              final dummyData = SubwayModel(
                subwayId: SubwayUtil.subwayLineToId(subwayLine),
                subwayName: subwayName,
                subwayLine: subwayLine,
                distance: distance,
                mainColor: SubwayUtil.getMainColor(subwayLine),
                stations: [],
                latLng: LatLng(
                  double.parse(element.latitude),
                  double.parse(element.longitude),
                ),
              );

              final List<SubwayDirectionStationModel> stationList = [];

              final tempList = subwayArrivalList!.where((element) => element.subwayId == dummyData.subwayId);

              groupBy(tempList, (p0) => p0.updnLine).forEach((key, arrivalList) {
                final isUp = arrivalList.first.ordkey.startsWith("0");
                var nameList = SubwayUtil.findSubwayNameList(
                  subwayId: arrivalList.first.subwayId,
                  currentStatnId: arrivalList.first.statnId,
                  preStatnId: arrivalList.first.statnFid,
                  nextStatnId: arrivalList.first.statnTid,
                  destination: arrivalList.first.trainLineNm.split(" ").first,
                  isUp: isUp,
                );

                final List<Pair<int, SubwayPositionModel?>> subwayPositionList =
                    List<Pair<int, SubwayPositionModel?>>.filled(nameList.length * 2 - 1, Pair(-1, null));

                for (var realTimeInfo in arrivalList) {
                  var subwayIndex =
                      !nameList.contains(realTimeInfo.arvlMsg3) ? -1 : (nameList.indexOf(realTimeInfo.arvlMsg3) * 2);

                  subwayIndex = subwayIndex + getSubwayAlignment(realTimeInfo.arvlCd, isUp);

                  if (subwayIndex >= 0 && subwayIndex < subwayPositionList.length) {
                    subwayPositionList[subwayIndex] = Pair(
                        subwayIndex,
                        SubwayPositionModel(
                          subwayName: realTimeInfo.statnNm,
                          destination: realTimeInfo.trainLineNm.split(" ").first.trim(),
                          arvlCd: realTimeInfo.arvlCd,
                          arvlMsg3: realTimeInfo.arvlMsg3,
                          ordkey: realTimeInfo.ordkey,
                        ));
                  }
                }

                final firstData = arrivalList.first;
                stationList.add(SubwayDirectionStationModel(
                  nameList: nameList,
                  destination: firstData.trainLineNm.split("-").first.trim().toString(),
                  nextStation: firstData.trainLineNm.split("-").last.trim().toString(),
                  btrainSttus: firstData.btrainSttus.split("-").last.trim().toString(),
                  subwayPositionList: subwayPositionList,
                  updnLine: firstData.updnLine,
                  arvlMsg2: firstData.arvlMsg2,
                  ordkey: firstData.ordkey,
                  arvlMsg3: firstData.arvlMsg3,
                ));
              });
              dummyData.stations = stationList;
              subwayDataList.add(dummyData);
            }
          }

          debugPrint("subwayDataList: $subwayDataList");

          if (!CollectionUtil.isNullorEmpty(subwayDataList)) {
            _changeUiState(
              Success(
                MainIntent(
                  userRegion: userRegion,
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

  _setUserRegion(List<String>? addressList) {
    if (!CollectionUtil.isNullorEmpty(addressList)) {
      userRegion = addressList!.join(" ");
    } else {
      final context = SubwayOdyApp.navigatorKey.currentContext as BuildContext;
      userRegion = getAppLocalizations(context).message_location_not_set;
    }
  }

  /// 현재 위치 가져오기
  _requestLatLng() async {
    final gpsInfo = await GetIt.instance<GetLatLngCallUseCase>().call();
    if (gpsInfo.latitude != null && gpsInfo.longitude != null) {
      latLng = gpsInfo;
    }
    debugPrint("_requestLatLng: $gpsInfo");
  }

  /// 현재 위치를 주소로 변환
  Future<List<String>?> _requestLatLngToRegion() async {
    List<String> addressList = [];
    debugPrint("_requestLatLngToRegion latLng : $latLng");
    if (latLng == null) return Future(() => null);
    final response = await GetIt.instance<GetKakaoLatLngToRegionUseCase>().call(latLng!);

    if (!CollectionUtil.isNullorEmpty(response.data?.documents)) {
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

    final tempDistance = distance ?? await GetIt.instance<GetUserDistanceUseCase>().call() ?? 500;

    final stationInfo = await GetIt.instance<GetNearBySubwayStationUseCase>().call(
      latLng!,
      tempDistance,
    );

    stationInfo.data?.documents?.forEach((element) {
      if (!CollectionUtil.isNullEmptyFromString(element.place_name)) {
        final sn = element.place_name!.split(" ").first;
        final sl = element.place_name!.split(" ").last;
        final findSn = SubwayUtil.findSubwayName(subwayName: sn, subwayLine: sl);

        debugPrint("_requestNearByStation findSn : $findSn");

        nearByStationList.add(
          NearByStation(
            subwayName: findSn,
            subwayLine: element.place_name!.split(" ").last,
            distance: element.distance.toString(),
            latitude: element.x.toString(),
            longitude: element.y.toString(),
          ),
        );
      }
    });

    debugPrint("_requestNearByStation nearByStationList : $nearByStationList");

    return nearByStationList;
  }

  /// 지하철 포지션 결정
  int getSubwayAlignment(String? arvlCd, bool isUp) {
    int alignment = 0;
    switch (arvlCd) {
      case "0": // 진입
        alignment = isUp ? 1 : -1;
        break;
      case "4": // 전역진입
        alignment = isUp ? 1 : -1;
        break;

      case "2": // 출발
        alignment = isUp ? -1 : 1;
        break;
      case "3": // 전역출발
        alignment = isUp ? -1 : 1;
        break;
      case "99": // 운행중
        alignment = isUp ? -1 : 1;
        break;

      case "1": // 도착
        alignment = isUp ? 0 : 0;
        break;
      case "5": // 전역도착
        alignment = isUp ? 0 : 0;
        break;
    }
    return alignment;
  }
}
