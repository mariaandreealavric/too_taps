import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_taps/generated/l10n.dart'; // Importa la classe S generata da intl
import '../controllers/language_controller.dart';

class LanguageMenu extends StatelessWidget {
  final LanguageController _languageController = Get.put(LanguageController());

  // Lista semplificata delle lingue supportate
  final List<Map<String, String>> languages = [
    {'code': 'en', 'country': 'US', 'name': 'English'},
    {'code': 'it', 'country': 'IT', 'name': 'Italiano'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _languageController.getSupportedLanguages().map((language) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InkWell(
            onTap: () {
              print('Tapped on: ${language['name']}');
              _languageController.changeLanguage(language['code']!, language['country']!);
              Get.snackbar(
                S.of(context).success,
                S.of(context).language_changed,
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                language['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
