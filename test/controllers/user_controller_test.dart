import 'package:flutter_test/flutter_test.dart';
import 'package:too_taps/controllers/user_controller.dart';
import 'package:too_taps/models/user_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  group('UserController', () {
    late FakeFirebaseFirestore firestore;
    late UserController controller;
    late UserModel user;

    setUp(() {
      firestore = FakeFirebaseFirestore();
      controller = UserController(firestore: firestore);
      user = UserModel(
        uid: '1',
        displayName: 'Test',
        email: 't@example.com',
        photoUrl: '',
        jobTitle: '',
        postImage: '',
      );
    });

    test('createProfile stores user and updates state', () async {
      await controller.createProfile(user);
      expect(controller.profile.value?.uid, '1');

      final doc = await firestore.collection('users').doc('1').get();
      expect(doc.exists, true);
      expect(doc.data()?['displayName'], 'Test');
    });

    test('incrementTouches updates value', () async {
      await controller.createProfile(user);
      controller.incrementTouches();
      await Future.delayed(Duration.zero);
      expect(controller.profile.value!.touches, 1);
    });

    test('incrementScrolls updates value', () async {
      await controller.createProfile(user);
      controller.incrementScrolls();
      await Future.delayed(Duration.zero);
      expect(controller.profile.value!.scrolls, 1);
    });
  });
}
