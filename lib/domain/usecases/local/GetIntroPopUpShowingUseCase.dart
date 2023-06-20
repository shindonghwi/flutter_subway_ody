import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';

class GetIntroPopUpShowingUseCase {
  GetIntroPopUpShowingUseCase();

  final LocalRepository _localRepository = GetIt.instance<LocalRepository>();

  Future<bool> call() async {
    return await _localRepository.getIntroPopUpShowing();
  }
}