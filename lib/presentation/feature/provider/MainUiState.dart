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
    Map<String, Pair<List<String>, SubwayDirectionStationModel>> updnMap = {};

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
            final subwayName = element.subwayName;
            final subwayLine = element.subwayLine;
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

              final dummyData = SubwayModel(
                  subwayId: SubwayUtil.subwayLineToId(subwayLine),
                  subwayName: subwayName,
                  subwayLine: subwayLine,
                  distance: distance,
                  mainColor: SubwayUtil.getMainColor(context, subwayLine),
                  stations: []);

              final List<SubwayDirectionStationModel> stationList = [];

              final tempList = subwayArrivalList!
                  .where((element) => element.subwayId == dummyData.subwayId);

              groupBy(tempList, (p0) => p0.updnLine).forEach((key, arrivalList) {

                var nameList = SubwayUtil.findSubwayNameList(
                  subwayId: arrivalList.first.subwayId,
                  currentStatnId: arrivalList.first.statnId,
                  preStatnId: arrivalList.first.statnFid,
                  nextStatnId: arrivalList.first.statnTid,
                  isUp: arrivalList.first.ordkey.startsWith("0"),
                );

                final List<Pair<int, SubwayPositionModel?>> subwayPositionList =
                    List<Pair<int, SubwayPositionModel?>>.filled(
                        nameList.length * 2 - 1, Pair(-1, null));

                for (var realTimeInfo in arrivalList) {
                  final subwayIndex = !nameList.contains(realTimeInfo.arvlMsg3)
                      ? -1
                      : (nameList.indexOf(realTimeInfo.arvlMsg3) * 2);
                  if (subwayIndex != -1) {
                    subwayPositionList[subwayIndex] = Pair(
                        subwayIndex,
                        SubwayPositionModel(
                          subwayName: realTimeInfo.statnNm,
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
        distance ?? await GetIt.instance<GetUserDistanceUseCase>().call() ?? 800;

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
