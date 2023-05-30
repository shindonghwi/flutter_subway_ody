import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/repositories/local/LocalGpsRepository.dart';

class PostAutoRefreshCallUseCase {
  PostAutoRefreshCallUseCase();

  final LocalGpsRepository _localGpsRepository = GetIt.instance<LocalGpsRepository>();

  Future<bool> call(bool isEnabled) async {
    return await _localGpsRepository.saveAutoRefreshCall(isEnabled);
  }
}
