import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';

class PatchIntroPopUpShowingUseCase {
  PatchIntroPopUpShowingUseCase();

  final LocalRepository _localRepository = GetIt.instance<LocalRepository>();

  Future<bool> call(bool state) async {
    return await _localRepository.patchIntroPopUpShowing(state);
  }
}
