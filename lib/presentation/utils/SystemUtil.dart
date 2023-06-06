import 'package:flutter/material.dart';
import 'package:subway_ody/presentation/feature/setting/models/LanguageType.dart';

class SystemUtil {
  static LanguageType getLanguageType(Locale locale) {
    if (locale.languageCode == "en") {
      return LanguageType.ENG;
    } else if (locale.languageCode == "ja") {
      return LanguageType.JPN;
    } else if (locale.languageCode == "zh") {
      return LanguageType.CHN;
    }
    return LanguageType.KOR;
  }
}
