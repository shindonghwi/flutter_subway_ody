import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';

class GetUserDistanceUseCase {
  GetUserDistanceUseCase();

  final LocalRepository _localRepository = GetIt.instance<LocalRepository>();

  Future<int?> call() async {
    return await _localRepository.getUserDistance();
  }
}
