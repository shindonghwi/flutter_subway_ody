import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/data_source/local/gps/LocalGpsApi.dart';
import 'package:subway_ody/domain/repositories/local/gps/LocalGpsRepository.dart';

class LocalGpsRepositoryImpl implements LocalGpsRepository {
  LocalGpsRepositoryImpl();

  @override
  Future<bool> getLocationPermission() {
    LocalGpsApi localGpsApi = GetIt.instance<LocalGpsApi>();
    return localGpsApi.getLocationPermission();
  }
}
