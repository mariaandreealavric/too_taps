import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:too_taps/Widgets/distance_counter_widget.dart';
import 'package:too_taps/controllers/Contatori/scroll_counter.dart';
import 'package:too_taps/models/user_model.dart';

void main() {
  testWidgets('DistanceCounterWidget displays scroll distance', (WidgetTester tester) async {
    final user = UserModel(
      uid: '1',
      displayName: 'Test',
      email: 't@example.com',
      photoUrl: '',
      jobTitle: '',
      postImage: '',
    );
    Get.put(ScrollCounter(user));

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DistanceCounterWidget(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('Distance from Earth'), findsOneWidget);
  });
}
