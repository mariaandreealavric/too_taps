import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // **Recupera il profilo utente da Firestore**
  Future<UserModel?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      print("Errore nel recupero profilo: $e");
      return null;
    }
  }

  // **Aggiorna il profilo dell'utente su Firestore**
  Future<void> updateUserProfile(String uid, UserModel profile) async {
    try {
      await _firestore.collection('users').doc(uid).set(profile.toMap(), SetOptions(merge: true));
    } catch (e) {
      print("Errore nell'aggiornamento profilo: $e");
    }
  }
}
