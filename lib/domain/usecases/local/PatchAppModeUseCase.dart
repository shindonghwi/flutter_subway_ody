import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';

class PatchAppModeUseCase {
  PatchAppModeUseCase();

  final LocalRepository _localRepository = GetIt.instance<LocalRepository>();

  Future<bool> call(bool isDemo) async {
    return await _localRepository.changeAppMode(isDemo);
  }
}
