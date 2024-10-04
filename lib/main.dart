import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/Contatori/scroll_counter.dart';
import 'controllers/profile_controller.dart';
import 'controllers/theme_controller.dart';
import 'services/notification_service.dart';
import 'widgets/navigazione/route_generator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final notificationService = NotificationService();
  await notificationService.initialize();

  // Inizializza il ProfileController con i dati mock
  Get.put(ProfileController());
  final profileController = Get.find<ProfileController>();
  profileController.setMockProfile('example_uid'); // Usa l'UID dei dati mock

  // Ottieni l'istanza del profilo dal ProfileController
  final userProfile = profileController.profile.value;

  if (userProfile != null) {
    // Inizializza ScrollCounter con il profilo utente
    Get.put(ScrollCounter(userProfile)); // Passa l'istanza di ProfileModel
  }

  // Inizializza il ThemeController
  Get.put(ThemeController());

  notificationService.scheduleDailyNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return GetMaterialApp(
      title: 'TOO-Taps',
      theme: themeController.currentTheme,
      initialRoute: '/',
      getPages: RouteGenerator.getPages,  // Utilizzo corretto di getPages da RouteGenerator
    );
  }
}
