import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  // Costruttore vuoto, caricheremo le traduzioni in modo asincrono
  Messages();

  static Map<String, Map<String, String>> translations = {};

  @override
  Map<String, Map<String, String>> get keys => translations;

  // Metodo per caricare le traduzioni
  static Future<void> loadTranslations() async {
    translations['en_US'] = await loadJson('assets/locales/en_US.json');
    translations['it_IT'] = await loadJson('assets/locales/it_IT.json');
  }

  // Carica il file JSON e convertilo in una mappa di stringhe
  static Future<Map<String, String>> loadJson(String path) async {
    String data = await rootBundle.loadString(path);
    Map<String, dynamic> result = json.decode(data);
    return result.map((key, value) => MapEntry(key, value.toString()));
  }
}
