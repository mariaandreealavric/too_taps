// controllers/scroll_counter.dart
import 'package:get/get.dart';
import '../../models/profile_model.dart';

class ScrollCounter extends GetxController {
  late ProfileModel userProfile; // Usa 'late' per l'inizializzazione successiva
  var scrolls = 0.obs; // Utilizza 'RxInt' per rendere la variabile reattiva

  ScrollCounter(ProfileModel profile) {
    userProfile = profile;
    scrolls.value = userProfile.scrolls; // Imposta il valore iniziale
  }

  void updateProfile(ProfileModel profile) {
    userProfile = profile;
    scrolls.value = profile.scrolls;
  }

  void incrementScrolls() {
    scrolls.value++;
    userProfile.scrolls = scrolls.value; // Aggiorna il modello
    //_updateProfileData(); // Aggiorna il database
  }

// Future<void> _updateProfileData() async {
//  try {
//   await FirebaseFirestore.instance.collection('users').doc(userProfile.uid).update({
//     'scrolls': userProfile.scrolls,
//   });
//  } catch (e) {
//     Get.snackbar('Error', 'Failed to update scrolls: \$e');
//   }
// }
}