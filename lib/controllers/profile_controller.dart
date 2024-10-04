import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../models/profile_model.dart';

// Dati mock per il profilo
final mockProfileData = {
  'displayName': 'Mock User',
  'email': 'mockuser@example.com',
  'photoUrl': 'https://example.com/default-photo.jpg',
  'touches': 0,
  'scrolls': 0,
  'trophies': [],
  'challenges': []
};

class ProfileController extends GetxController {
  final Logger _logger = Logger();
  var profile = Rx<ProfileModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Metodo per impostare il profilo con dati mock
  void setMockProfile(String uid) {
    _logger.i('Utilizzando dati mock per il profilo: $uid');
    profile.value = ProfileModel.fromFirestore(mockProfileData, uid);
  }

  // Metodo per assicurarsi che il profilo esista o crearlo con dati mock
  Future<void> ensureProfileExists(String uid) async {
    _logger.i('Verifica dell\'esistenza del profilo per l\'utente: $uid');
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 1));
      profile.value = ProfileModel.fromFirestore(mockProfileData, uid);
    } catch (e) {
      errorMessage.value = 'Errore durante il caricamento del profilo';
      _logger.e('Errore durante il caricamento del profilo: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Metodo per aggiornare il profilo
  Future<void> updateProfile(ProfileModel updatedProfile) async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulazione di un aggiornamento remoto
      profile.value = updatedProfile;
      _logger.i('Profilo aggiornato con successo');
    } catch (e) {
      errorMessage.value = 'Errore durante l\'aggiornamento del profilo';
      _logger.e('Errore durante l\'aggiornamento del profilo: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Incrementa il numero di "touches"
  void incrementTouches() {
    if (profile.value != null) {
      profile.value!.touches++;
      profile.refresh();
      _logger.i('Touches incrementati: ${profile.value!.touches}');
    }
  }

  // Incrementa il numero di "scrolls"
  void incrementScrolls() {
    if (profile.value != null) {
      profile.value!.scrolls++;
      profile.refresh();
      _logger.i('Scrolls incrementati: ${profile.value!.scrolls}');
    }
  }

  // Aggiunge un trofeo al profilo
  void addTrophy(String trophy) {
    if (profile.value != null) {
      profile.value!.trophies.add(trophy);
      profile.refresh();
      _logger.i('Trofeo aggiunto: $trophy');
    }
  }

  // Aggiunge una nuova sfida al profilo
  void addChallenge(Map<String, dynamic> challenge) {
    if (profile.value != null) {
      profile.value!.challenges.add(challenge);
      profile.refresh();
      _logger.i('Sfida aggiunta: ${challenge['name']}');
    }
  }
}
