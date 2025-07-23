import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:too_taps/services/post_ai_service.dart';

void main() {
  test('generatePost returns trimmed response text', () async {
    final mockClient = MockClient((request) async {
      final body = jsonEncode({
        'candidates': [
          {
            'content': {
              'parts': [
                {'text': '  hello world  '}
              ]
            }
          }
        ]
      });
      return http.Response(body, 200);
    });

    final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: 'test-key',
      httpClient: mockClient,
    );

    final result =
        await PostAIService.instance.generatePost(2, 3, model: model);
    expect(result, 'hello world');
  });
}
