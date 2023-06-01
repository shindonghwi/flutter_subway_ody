import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/data_source/local/LocalApi.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';

class LocalRepositoryImpl implements LocalRepository {
  LocalRepositoryImpl();

  @override
  Future<bool> getLocationPermission() async {
    LocalApi localApi = GetIt.instance<LocalApi>();
    return await localApi.getLocationPermission();
  }

  @override
  Future<bool> getAutoRefreshCall() async {
    LocalApi localApi = GetIt.instance<LocalApi>();
    return await localApi.getAutoRefreshCall();
  }

  @override
  Future<bool> saveAutoRefreshCall(bool isEnabled) async {
    LocalApi localApi = GetIt.instance<LocalApi>();
    return await localApi
        .saveAutoRefreshCall(isEnabled)
        .whenComplete(() => true)
        .onError((error, stackTrace) => false);
  }

  @override
  Future<LatLng> getLatLng() async {
    LocalApi localApi = GetIt.instance<LocalApi>();
    return await localApi.getLatLng();
  }

  @override
  Future<int> getUserDistance() async {
    LocalApi localApi = GetIt.instance<LocalApi>();
    return await localApi.getUserDistance();
  }

  @override
  Future<bool> saveUserDistance(int distance) async {
    LocalApi localApi = GetIt.instance<LocalApi>();
    return await localApi.saveUserDistance(distance);
  }
}
