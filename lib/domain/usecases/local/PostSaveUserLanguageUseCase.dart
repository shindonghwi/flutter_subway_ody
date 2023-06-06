import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';
import 'package:subway_ody/presentation/feature/setting/models/LanguageType.dart';

class PostSaveUserLanguageUseCase {
  PostSaveUserLanguageUseCase();

  final LocalRepository _localRepository = GetIt.instance<LocalRepository>();

  Future<bool> call(LanguageType type) async {
    return await _localRepository.saveUserLanguage(type);
  }
}
