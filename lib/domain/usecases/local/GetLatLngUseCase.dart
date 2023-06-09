import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';
import 'package:subway_ody/firebase/Analytics.dart';

class GetLatLngCallUseCase {
  GetLatLngCallUseCase();

  final LocalRepository _localRepository = GetIt.instance<LocalRepository>();

  Future<LatLng> call() async {
    final latlng = await _localRepository.getLatLng();
    Analytics.eventSetUserLatLng(latlng);
    return latlng;
  }
}
