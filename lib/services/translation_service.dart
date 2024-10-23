import 'dart:convert';
import 'package:flutter/services.dart';

class TranslationService {
  static Future<Map<String, Map<String, String>>> loadTranslations() async {
    Map<String, Map<String, String>> translations = {};

    // Elenco delle lingue supportate
    List<String> languages = ['en', 'it']; // Aggiungi altre lingue se necessario

    for (String lang in languages) {
      String jsonString = await rootBundle.loadString('lib/l10n/intl_$lang.arb');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Rimuovi le meta-informazioni
      jsonMap.removeWhere((key, value) => key.startsWith('@'));

      // Converti i valori a stringhe
      Map<String, String> stringMap = jsonMap.map((key, value) => MapEntry(key, value.toString()));

      translations['${lang}_${lang.toUpperCase()}'] = stringMap;
    }

    return translations;
  }
}
