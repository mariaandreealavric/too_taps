// controllers/settings_controller.dart
import 'package:get/get.dart';

import '../services/notification_service.dart';

class SettingsController extends GetxController {
  final NotificationService _notificationService = Get.find();

  var notificationsEnabled = false.obs;
  var selectedLanguage = 'English'.obs;
  var selectedTransition = 'fadeIn'.obs;
  final languages = ['English', 'Italian', 'Spanish', 'French'];
  final transitions = ['fadeIn', 'fade', 'rightToLeft', 'downToUp'];

  Future<void> setNotifications(bool enabled) async {
    notificationsEnabled.value = enabled;

    if (enabled) {
      final granted = await _notificationService.requestPermissions();
      if (granted) {
        await _notificationService.scheduleDailyReportNotification();
      } else {
        notificationsEnabled.value = false;
        Get.snackbar('Notifiche', 'Permesso alle notifiche negato');
      }
    } else {
      await _notificationService.cancelReportNotification();
    }
  }

  void changeLanguage(String language) {
    selectedLanguage.value = language;
  }

  void changeTransition(String transition) {
    selectedTransition.value = transition;
  }
}
