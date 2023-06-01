import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';

class PostSaveUserDistanceUseCase {
  PostSaveUserDistanceUseCase();

  final LocalRepository _localRepository = GetIt.instance<LocalRepository>();

  Future<bool> call(int distance) async {
    return await _localRepository.saveUserDistance(distance);
  }
}
