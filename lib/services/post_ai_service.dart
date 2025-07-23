import 'dart:ui';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:get/get.dart';

class PostAIService {
  PostAIService._({GenerativeModel? model}) : _model = model;

  final GenerativeModel? _model;

  static final PostAIService instance = PostAIService._();

  Future<String> generatePost(int scrolls, int touches, {GenerativeModel? model}) async {
    final locale = Get.locale ?? const Locale('en', 'US');
    final languageCode = locale.languageCode;

    final apiKey = const String.fromEnvironment('GOOGLE_API_KEY', defaultValue: '');
    if (apiKey.isEmpty && model == null && _model == null) {
      // Simple fallback text if no API key is provided
      if (languageCode == 'it') {
        return 'Ho toccato solo $touches volte e scrollato $scrolls volte oggi! Continua così!';
      }
      return 'I touched only $touches times and scrolled $scrolls times today! Keep it up!';
    }

    final languageName = _languageName(languageCode);

    final generativeModel = model ?? _model ?? GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final prompt =
        'Create a short motivational post celebrating that the user performed only $touches touches and $scrolls scrolls. Reply in $languageName.';
    final response = await generativeModel.generateContent([
      Content.text(prompt)
    ]);
    return response.text?.trim() ?? '';
  }

  String _languageName(String code) {
    switch (code) {
      case 'it':
        return 'Italian';
      case 'en':
        return 'English';
      default:
        return code;
    }
  }
}
