// controllers/scroll_counter.dart
import 'package:get/get.dart';
import '../../models/user_model.dart';
import '../post_controller.dart';

class ScrollCounter extends GetxController {
  late UserModel userProfile; // Usa 'late' per l'inizializzazione successiva
  var scrolls = 0.obs; // Utilizza 'RxInt' per rendere la variabile reattiva

  ScrollCounter(UserModel profile) {
    userProfile = profile;
    scrolls.value = userProfile.scrolls; // Imposta il valore iniziale
  }

  void updateProfile(UserModel profile) {
    userProfile = profile;
    scrolls.value = profile.scrolls;
  }

  void incrementScrolls() {
    scrolls.value++;
    userProfile.scrolls = scrolls.value; // Aggiorna il modello
    if (Get.isRegistered<PostController>()) {
      Get.find<PostController>().checkGoals();
    }
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