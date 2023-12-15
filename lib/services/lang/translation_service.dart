import 'package:contacts/services/lang/en.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationService extends Translations {
  static Locale? get locale => Locale(getLanguageCode());
  static const fallbackLocale = Locale('en');

  static String getLanguageCode() {
    // String? storageLanguageCode = GetStorage().read(AppString.languageCodeKey);
    // if (storageLanguageCode != null) {
    //   return storageLanguageCode;
    // } else {
    //   String? languageCode = Get.deviceLocale?.languageCode;
    //   if (languageCode != null) {
    //     if (languageCode.contains('en')) {
    //       return 'en';
    //     } else if (languageCode.contains('zh')) {
    //       return 'zh';
    //     } else if (languageCode.contains('ms')) {
    //       return 'ms';
    //     }
    //   } else {
    //     return 'en';
    //   }
    // }
    return 'en';
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        // 'ms': ms,
        // 'zh': zh,
      };
}
