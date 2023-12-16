import 'package:contacts/services/lang/en.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationService extends Translations {
  static Locale? get locale => Locale(getLanguageCode());
  static const fallbackLocale = Locale('en');

  static String getLanguageCode() {
    return 'en';
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
      };
}
