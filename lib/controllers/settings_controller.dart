// controllers/settings_controller.dart
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var notificationsEnabled = false.obs;
  var selectedLanguage = 'English'.obs;
  var selectedTransition = 'fadeIn'.obs;
  final languages = ['English', 'Italian', 'Spanish', 'French'];
  final transitions = ['fadeIn', 'fade', 'rightToLeft', 'downToUp'];

  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
  }

  void changeLanguage(String language) {
    selectedLanguage.value = language;
  }

  void changeTransition(String transition) {
    selectedTransition.value = transition;
  }
}