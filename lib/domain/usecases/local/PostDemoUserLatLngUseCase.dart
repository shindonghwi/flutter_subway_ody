import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';
import 'package:subway_ody/firebase/Analytics.dart';

class PostDemoUserLatLngUseCase {
  PostDemoUserLatLngUseCase();

  final LocalRepository _localRepository = GetIt.instance<LocalRepository>();

  Future<bool> call(int distance) async {
    return await _localRepository.saveUserDistance(distance);
  }
}
