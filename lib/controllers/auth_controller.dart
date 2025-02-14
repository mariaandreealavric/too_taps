import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:too_taps/controllers/user_controller.dart';

import '../models/user_model.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs; // Stato di autenticazione
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  /// Getter per l'utente corrente
  UserModel? get currentUser => Get.find<UserController>().profile.value ?? null;

  /// Registra un utente su Firebase Authentication e salva i dati in Firestore
  Future<void> registerUser(String email, String password) async {
    try {
      // Crea l'utente su Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = userCredential.user!.uid;

      // Crea il profilo utente
      UserModel newUser = UserModel(
        uid: userId,
        displayName: '', // Il nome può essere aggiornato dopo la registrazione
        email: email,
        photoUrl: '', // L'utente può caricare la foto in seguito
        jobTitle: '',
        postImage: '',
        touches: 0,
        scrolls: 0,
        trophies: [],
        challenges: [],
      );

      print('Utente registrato con successo: $userId');

      // Salva il profilo utente in Firestore
      await saveUserProfile(newUser);

      // Carica l'utente corrente nel controller
      final userController = Get.find<UserController>();
      await userController.loadProfile(userId);

      print('Registrazione completata con successo.');
    } catch (e) {
      print('Errore durante la registrazione: $e');
      throw 'Errore durante la registrazione: ${e.toString()}';
    }
  }


  /// Salva il profilo utente in Firestore
  Future<void> saveUserProfile(UserModel user) async {
    try {
      if (user.uid.isEmpty || user.email.isEmpty) {
        print('ID utente o email mancanti!');
        return;
      }

      await _firestore.collection('users').doc(user.uid).set(user.toMap());
      print('Profilo utente salvato correttamente.');
    } catch (e) {
      print('Errore durante il salvataggio del profilo: $e');
      throw 'Errore durante il salvataggio del profilo: ${e.toString()}';
    }
  }

}
