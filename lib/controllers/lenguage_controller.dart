import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  // Metodo per cambiare la lingua dell'applicazione
  void changeLanguage(String languageCode, String countryCode) {
    var locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale); // Cambia la lingua con GetX
  }

  // Metodo per ottenere la lingua corrente
  Locale get currentLocale => Get.locale ?? Locale('en', 'US');

  // Metodo per restituire una lista di lingue supportate
  List<Map<String, String>> getSupportedLanguages() {
    return [
      {'code': 'en', 'name': 'English', 'country': 'US'},
      {'code': 'it', 'name': 'Italiano', 'country': 'IT'},
      {'code': 'es', 'name': 'Español', 'country': 'ES'},
      {'code': 'fr', 'name': 'Français', 'country': 'FR'},
      {'code': 'zh', 'name': '中文', 'country': 'CN'},
    ];
  }
}