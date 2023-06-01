import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';

class GetLatLngCallUseCase {
  GetLatLngCallUseCase();

  final LocalRepository _localRepository = GetIt.instance<LocalRepository>();

  Future<LatLng> call() async {
    return await _localRepository.getLatLng();
  }
}
