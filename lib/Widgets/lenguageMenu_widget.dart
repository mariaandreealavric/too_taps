import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lenguage_controller.dart';

class LanguageMenu extends StatelessWidget {
  final LanguageController _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _languageController.getSupportedLanguages().map((language) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              // Cambia la lingua
              _languageController.changeLanguage(
                language['code']!,
                language['country']!,
              );

              // Mostra una Snackbar per confermare il cambiamento
              Get.snackbar(
                'success'.tr, // Traduzione della parola "Successo"
                'language_changed'.tr, // Traduzione del messaggio "Lingua cambiata"
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
            child: Text(
              language['name']!,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.blue, // Colore del testo delle lingue
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
