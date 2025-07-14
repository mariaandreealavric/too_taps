import 'package:flutter_test/flutter_test.dart';
import 'package:too_taps/controllers/Contatori/scroll_counter.dart';
import 'package:too_taps/models/user_model.dart';

void main() {
  group('ScrollCounter', () {
    late UserModel user;

    setUp(() {
      user = UserModel(
        uid: '1',
        displayName: 'Test',
        email: 't@example.com',
        photoUrl: '',
        jobTitle: '',
        postImage: '',
        scrolls: 3,
      );
    });

    test('initializes with user scrolls', () {
      final counter = ScrollCounter(user);
      expect(counter.scrolls.value, 3);
    });

    test('incrementScrolls increases scrolls', () {
      final counter = ScrollCounter(user);
      counter.incrementScrolls();
      expect(counter.scrolls.value, 4);
      expect(user.scrolls, 4);
    });

    test('updateProfile replaces user data', () {
      final counter = ScrollCounter(user);
      final newUser = user.copyWith(scrolls: 7);
      counter.updateProfile(newUser);
      expect(counter.scrolls.value, 7);
      expect(counter.userProfile.scrolls, 7);
    });
  });
}
