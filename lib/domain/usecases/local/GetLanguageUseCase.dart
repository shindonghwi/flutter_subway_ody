import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';

class GetLanguageUseCase {
  GetLanguageUseCase();

  final LocalRepository _localRepository = GetIt.instance<LocalRepository>();

  Future<Locale> call() async {
    return await _localRepository.getUserLanguage();
  }
}
