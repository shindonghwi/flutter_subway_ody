import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/data_source/local/LocalGpsApi.dart';
import 'package:subway_ody/domain/models/LatLng.dart';
import 'package:subway_ody/domain/repositories/local/LocalGpsRepository.dart';

class LocalGpsRepositoryImpl implements LocalGpsRepository {
  LocalGpsRepositoryImpl();

  @override
  Future<bool> getLocationPermission() async {
    LocalGpsApi localGpsApi = GetIt.instance<LocalGpsApi>();
    return await localGpsApi.getLocationPermission();
  }

  @override
  Future<bool> getAutoRefreshCall() async {
    LocalGpsApi localGpsApi = GetIt.instance<LocalGpsApi>();
    return await localGpsApi.getAutoRefreshCall();
  }

  @override
  Future<bool> saveAutoRefreshCall(bool isEnabled) async {
    LocalGpsApi localGpsApi = GetIt.instance<LocalGpsApi>();
    return await localGpsApi
        .saveAutoRefreshCall(isEnabled)
        .whenComplete(() => true)
        .onError((error, stackTrace) => false);
  }

  @override
  Future<LatLng> getLatLng() async {
    LocalGpsApi localGpsApi = GetIt.instance<LocalGpsApi>();
    return await localGpsApi.getLatLng();
  }
}
