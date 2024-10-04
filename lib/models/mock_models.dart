// Mock AuthModel

import 'package:too_taps/models/profile_model.dart';

import 'auth_model.dart';

class MockAuthModel extends AuthModel {
  MockAuthModel()
      : super(
    uid: 'example_uid',
    email: 'example@example.com',
    displayName: 'Example User',
    photoUrl: 'https://example.com/photo.jpg',
  );
}

// Mock ProfileModel
class MockProfileModel extends ProfileModel {
  MockProfileModel()
      : super(
    uid: 'example_uid',
    displayName: 'Example User',
    email: 'example@example.com',
    photoUrl: 'https://example.com/photo.jpg',
    touches: 5,
    scrolls: 10,
    trophies: ['Trophy1', 'Trophy2'],
    challenges: [
      {'name': 'Challenge1', 'completed': false},
      {'name': 'Challenge2', 'completed': true}
    ],
  );
}
