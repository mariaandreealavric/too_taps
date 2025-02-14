import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'package:logger/logger.dart';

class UserController extends GetxController {
  final Logger _logger = Logger();
  var profile = Rx<UserModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // **Getter per ottenere l'utente attuale**
  UserModel? get currentUser => profile.value;

  // **Carica il profilo dell'utente attualmente autenticato**
  Future<void> loadCurrentUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await loadProfile(user.uid);
    } else {
      errorMessage.value = 'Nessun utente autenticato';
    }
  }

  // **Carica il profilo da Firebase Firestore**
  Future<void> loadProfile(String uid) async {
    _logger.i('Caricamento del profilo per l\'utente: $uid');
    isLoading.value = true;

    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists && doc.data() != null) {
        profile.value = UserModel.fromFirestore(doc.data()!, uid);
        _logger.i('Profilo caricato con successo per l\'utente: ${profile.value!.displayName}');
      } else {
        errorMessage.value = 'Nessun profilo trovato per questo utente';
        _logger.w('Profilo non trovato per UID: $uid');
      }
    } catch (e) {
      errorMessage.value = 'Errore durante il caricamento del profilo';
      _logger.e('Errore durante il caricamento del profilo: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // **Crea un nuovo profilo se non esiste**
  Future<void> createProfile(UserModel newProfile) async {
    isLoading.value = true;
    try {
      await _firestore.collection('users').doc(newProfile.uid).set(newProfile.toMap());
      profile.value = newProfile;
      _logger.i('Profilo creato con successo per ${newProfile.displayName}');
    } catch (e) {
      errorMessage.value = 'Errore durante la creazione del profilo';
      _logger.e('Errore durante la creazione del profilo: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // **Aggiorna il profilo su Firestore**
  Future<void> updateProfile(UserModel updatedProfile) async {
    isLoading.value = true;
    try {
      await _firestore.collection('users').doc(updatedProfile.uid).update(updatedProfile.toMap());
      profile.value = updatedProfile;
      _logger.i('Profilo aggiornato con successo');
    } catch (e) {
      errorMessage.value = 'Errore durante l\'aggiornamento del profilo';
      _logger.e('Errore durante l\'aggiornamento del profilo: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // **Incrementa il numero di "touches"**
  void incrementTouches() {
    if (profile.value != null) {
      profile.value!.touches++;
      updateProfile(profile.value!);
      profile.refresh();
      _logger.i('Touches incrementati: ${profile.value!.touches}');
    }
  }

  // **Incrementa il numero di "scrolls"**
  void incrementScrolls() {
    if (profile.value != null) {
      profile.value!.scrolls++;
      updateProfile(profile.value!);
      profile.refresh();
      _logger.i('Scrolls incrementati: ${profile.value!.scrolls}');
    }
  }

  // **Aggiunge un trofeo al profilo**
  void addTrophy(String trophy) {
    if (profile.value != null) {
      profile.value!.trophies.add(trophy);
      updateProfile(profile.value!);
      profile.refresh();
      _logger.i('Trofeo aggiunto: $trophy');
    }
  }

  // **Aggiunge una nuova sfida al profilo**
  void addChallenge(Map<String, dynamic> challenge) {
    if (profile.value != null) {
      profile.value!.challenges.add(challenge);
      updateProfile(profile.value!);
      profile.refresh();
      _logger.i('Sfida aggiunta: ${challenge['name']}');
    }
  }

  Future<UserModel?> getRandomProfile() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('users').get();

      if (snapshot.docs.isNotEmpty) {
        final randomDoc = snapshot.docs[DateTime.now().millisecondsSinceEpoch % snapshot.docs.length];
        return UserModel.fromFirestore(randomDoc.data() as Map<String, dynamic>, randomDoc.id);
      }
      return null;
    } catch (e) {
      _logger.e("Errore nel recupero di un profilo casuale: $e");
      return null;
    }
  }


}
