import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/repositories/local/LocalGpsRepository.dart';

class GetAutoRefreshCallUseCase {
  GetAutoRefreshCallUseCase();

  final LocalGpsRepository _localGpsRepository = GetIt.instance<LocalGpsRepository>();

  Future<bool> call() async {
    return await _localGpsRepository.getAutoRefreshCall();
  }
}
