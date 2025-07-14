import 'package:flutter_test/flutter_test.dart';
import 'package:too_taps/controllers/Contatori/touch_counter.dart';
import 'package:too_taps/models/user_model.dart';

void main() {
  group('TouchCounter', () {
    late UserModel user;

    setUp(() {
      user = UserModel(
        uid: '1',
        displayName: 'Test',
        email: 't@example.com',
        photoUrl: '',
        jobTitle: '',
        postImage: '',
        touches: 5,
      );
    });

    test('initializes with user touches', () {
      final counter = TouchCounter(user);
      expect(counter.touches.value, 5);
    });

    test('incrementTouches increases touches', () {
      final counter = TouchCounter(user);
      counter.incrementTouches();
      expect(counter.touches.value, 6);
      expect(user.touches, 6);
    });

    test('updateProfile replaces user data', () {
      final counter = TouchCounter(user);
      final newUser = user.copyWith(touches: 10);
      counter.updateProfile(newUser);
      expect(counter.touches.value, 10);
      expect(counter.userProfile.touches, 10);
    });
  });
}
