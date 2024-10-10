import 'dart:math';  // Per generare profili casuali
import 'package:too_taps/models/profile_model.dart';
import 'auth_model.dart';

// Mock AuthModel
class MockAuthModel extends AuthModel {
  MockAuthModel()
      : super(
    uid: 'example_uid',
    email: 'example@example.com',
    displayName: 'Alberto Spina',
    photoUrl: 'assets/mock/profilo1.jpg',
    jobTitle: 'Technician',
  );
}

// Mock ProfileModel
class MockProfileModel extends ProfileModel {
  MockProfileModel()
      : super(
    uid: 'example_uid',
    displayName: 'Alberto Spina',
    email: 'example@example.com',
    photoUrl: 'assets/mock/profilo1.jpg',
    postImage: 'assets/mock/sfondo1.jpeg',
    jobTitle: 'Technician',
    touches: 5,
    scrolls: 10,
    trophies: ['Trophy1', 'Trophy2'],
    challenges: [
      {'name': 'Challenge1', 'completed': false},
      {'name': 'Challenge2', 'completed': true}
    ],
  );
}

// Lista di profili fittizi
final List<ProfileModel> mockProfiles = [
  ProfileModel(
    uid: '1',
    displayName: 'Monica Neri',
    email: 'monica@example.com',
    photoUrl: 'assets/mock/profilo2.jpg',
    postImage: 'assets/mock/sfondo1.jpeg',
    jobTitle: 'Ristoratrice',
    touches: 10,
    scrolls: 5,
    trophies: ['Medaglia d\'oro'],
    challenges: [{'name': 'Challenge1', 'completed': true}],
  ),
  ProfileModel(
    uid: '2',
    displayName: 'Antonio Ratto',
    email: 'antonio@example.com',
    photoUrl: 'assets/mock/profilo3.jpg',
    postImage: 'assets/mock/sfondo2.jpg',
    jobTitle: 'Programmatore',
    touches: 15,
    scrolls: 8,
    trophies: ['Campione di Tap'],
    challenges: [{'name': 'Challenge2', 'completed': false}],
  ),
  ProfileModel(
    uid: '3',
    displayName: 'Luisa Verdi',
    email: 'luisa@example.com',
    photoUrl: 'assets/mock/profilo4.jpg',
    postImage: 'assets/mock/sfondo3.jpg',
    jobTitle: 'Designer',
    touches: 20,
    scrolls: 12,
    trophies: ['Designer dell\'anno'],
    challenges: [{'name': 'Challenge3', 'completed': true}],
  ),
];

// Funzione per ottenere un profilo casuale
ProfileModel getRandomProfile() {
  final random = Random();
  return mockProfiles[random.nextInt(mockProfiles.length)];
}
