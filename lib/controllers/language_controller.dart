import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class LanguageController extends GetxController {
  // Metodo per cambiare la lingua dell'applicazione
  void changeLanguage(String languageCode, String countryCode) {
    var locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale); // Cambia la lingua con GetX
  }


  // Metodo per restituire una lista di lingue supportate
  List<Map<String, String>> getSupportedLanguages() {
    return [
      {'code': 'en', 'name': 'English', 'country': 'US'},
      {'code': 'it', 'name': 'Italiano', 'country': 'IT'},
      // Aggiungi altre lingue qui, se necessario
    ];
  }
}

