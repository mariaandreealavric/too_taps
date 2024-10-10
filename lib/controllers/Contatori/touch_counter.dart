// controllers/touch_controller.dart
//import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/profile_model.dart';

class TouchCounter extends GetxController {
  late ProfileModel userProfile; // Usa 'late' per l'inizializzazione successiva
  var touches = 0.obs; // Utilizza 'RxInt' per rendere la variabile reattiva

  TouchCounter(ProfileModel profile) {
    userProfile = profile;
    touches.value = userProfile.touches; // Imposta il valore iniziale
  }

  void updateProfile(ProfileModel profile) {
    userProfile = profile;
    touches.value = profile.touches;
  }

  void incrementTouches() {
    touches.value++;
    userProfile.touches = touches.value; // Aggiorna il modello
    //_updateProfileData(); // Aggiorna il database
  }

// Future<void> _updateProfileData() async {
//  try {
//   await FirebaseFirestore.instance.collection('users').doc(userProfile.uid).update({
//     'touches': userProfile.touches,
//   });
//  } catch (e) {
//     Get.snackbar('Error', 'Failed to update touches: $e');
//   }
// }
}
