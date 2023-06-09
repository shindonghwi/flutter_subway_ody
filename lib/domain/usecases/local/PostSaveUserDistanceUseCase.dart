import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';
import 'package:subway_ody/firebase/Analytics.dart';

class PostSaveUserDistanceUseCase {
  PostSaveUserDistanceUseCase();

  final LocalRepository _localRepository = GetIt.instance<LocalRepository>();

  Future<bool> call(int distance) async {
    Analytics.eventSetDistance(distance);
    return await _localRepository.saveUserDistance(distance);
  }
}
