import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:too_taps/main.dart';
import 'package:too_taps/Views/home_page.dart';
import 'package:too_taps/controllers/theme_controller.dart';

void main() {
  setUp(() {
    // Provide required controllers for the app.
    Get.put(ThemeController());
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('MyApp shows HomePage on startup', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });
}
