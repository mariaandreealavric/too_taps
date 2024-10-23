import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:too_taps/services/translation_service.dart';
import 'Views/Settings/localization/messages.dart';
import 'Views/Settings/permission_handler.dart';
import 'controllers/Contatori/scroll_counter.dart';
import 'controllers/Contatori/touch_counter.dart';
import 'controllers/lenguage_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/theme_controller.dart';
import 'generated/l10n.dart';
import 'services/notification_service.dart';
import 'widgets/navigazione/route_generator.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Carica le traduzioni
  Map<String, Map<String, String>> translations = await TranslationService.loadTranslations();

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

  if (userProfile != null) {
    // Inizializza TouchCounter con il profilo utente
    Get.put(TouchCounter(userProfile)); // Passa l'istanza di ProfileModel
  }

  // Inizializza il ThemeController
  Get.put(ThemeController());
  Get.put(LanguageController());


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return GetMaterialApp(
      title: 'TOO-Taps',
      fallbackLocale: const Locale('en', 'US'),
      translations: Messages(), // Imposta le traduzioni
      locale: Get.deviceLocale, // Imposta la lingua predefinita del dispositivo
      supportedLocales: const [
        Locale('en', 'US'), // Inglese (Stati Uniti)
        Locale('it', 'IT'), // Italiano (Italia)
        // Aggiungi altre lingue se necessario
      ],
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate, // Supporto per localizzazioni Material
        GlobalWidgetsLocalizations.delegate,  // Supporto per localizzazioni dei widget generici
        GlobalCupertinoLocalizations.delegate, // Supporto per localizzazioni dei widget Cupertino
        // Aggiungi il tuo delegato di traduzione se stai usando intl o GetX
      ],
      theme: themeController.currentTheme,
      initialRoute: '/',
      getPages: RouteGenerator.getPages, // Utilizzo corretto di getPages da RouteGenerator
      builder: (context, child) {
        // Aggiungi uno sfondo a tutte le pagine
        return Container(
          decoration: themeController.boxDecoration,
          child: child,
        );
      },
    );
  }
}
