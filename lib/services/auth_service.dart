import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class MockUser {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;

  MockUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
  });
}

class AuthService with ChangeNotifier {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseStorage _storage = FirebaseStorage.instance;
  final Logger _logger = Logger();

  MockUser? _mockUser;

  MockUser? get currentUser => _mockUser;

  Stream<MockUser?> get authStateChanges => _authStateController.stream;

  final StreamController<MockUser?> _authStateController = StreamController<MockUser?>();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    // Simula un login
    _mockUser = MockUser(
      uid: 'mock_uid',
      email: email,
      displayName: 'Mock User',
      photoUrl: 'https://example.com/mockphoto.jpg',
    );
    _authStateController.add(_mockUser);
    notifyListeners();
  }

  Future<void> signUpWithEmailAndPassword(String email, String password, String name, File image) async {
    try {
      // Simula la creazione di un utente
      String imageUrl = await uploadProfileImage('mock_uid', image);
      _mockUser = MockUser(
        uid: 'mock_uid',
        email: email,
        displayName: name,
        photoUrl: imageUrl,
      );
      // await addUserData(_mockUser!.uid, email, name, imageUrl);
      _authStateController.add(_mockUser);
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }

  Future<void> addUserData(String uid, String email, String nome, String imageUrl) async {
    // Simula l'aggiunta di dati utente
    _logger.i('Dati utente aggiunti per $uid');
    // await _firestore.collection('users').doc(uid).set({
    //   'uid': uid,
    //   'email': email,
    //   'displayName': nome,
    //   'photoUrl': imageUrl,
    //   'touches': 0,
    //   'scrolls': 0,
    //   'trophies': [],
    //   'challenges': [],
    // });
  }

  Future<String> uploadProfileImage(String uid, File image) async {
    try {
      // Simula l'upload di un'immagine
      _logger.i('Immagine caricata per $uid');
      return 'https://example.com/mockphoto.jpg';
      // TaskSnapshot snapshot = await _storage.ref('profileImages/$uid').putFile(image);
      // return await snapshot.ref.getDownloadURL();
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    _mockUser = null;
    _authStateController.add(_mockUser);
    notifyListeners();
  }

  // Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) {
  //   return _firestore.collection('users').doc(uid).get();
  // }

  @override
  void dispose() {
    _authStateController.close();
    super.dispose();
  }
}
