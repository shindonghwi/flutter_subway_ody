import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/models/LatLng.dart';
import 'package:subway_ody/domain/repositories/local/LocalGpsRepository.dart';

class GetLatLngCallUseCase {
  GetLatLngCallUseCase();

  final LocalGpsRepository _localGpsRepository = GetIt.instance<LocalGpsRepository>();

  Future<LatLng> call() async {
    return await _localGpsRepository.getLatLng();
  }
}
