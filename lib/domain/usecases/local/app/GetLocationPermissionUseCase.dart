import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/repositories/local/gps/LocalGpsRepository.dart';

class GetLocationPermissionUseCase {
  GetLocationPermissionUseCase();

  final LocalGpsRepository _localGpsRepository = GetIt.instance<LocalGpsRepository>();

  Future<bool> call() async {
    return await _localGpsRepository.getLocationPermission();
  }
}
