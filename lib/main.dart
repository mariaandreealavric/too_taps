import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'controllers/Contatori/scroll_counter.dart';
import 'controllers/Contatori/touch_counter.dart';
import 'controllers/language_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/theme_controller.dart';
import 'generated/l10n.dart';
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

  static const platform = MethodChannel('com.yourapp/native_events');

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    print('Current locale: ${Get.locale}'); // Log per verifica
    // Inizializza il metodo per ascoltare gli eventi nativi
    _initializeMethodChannel();

    return GetMaterialApp(
      title: 'TOO-Taps',
      locale: Get.locale ?? Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: S.delegate.supportedLocales, // Lingue supportate
      localizationsDelegates: const [
        S.delegate, // Classe generata per le traduzioni
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
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

  void _initializeMethodChannel() {
    platform.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onTouchEvent':
          _handleTouchEvent();
          break;
        case 'onScrollEvent':
          _handleScrollEvent();
          break;
        default:
          throw MissingPluginException('Not implemented: ${call.method}');
      }
    });
  }

  void _handleTouchEvent() {
    // Logica per gestire l'evento di tocco
    print('Touch event detected');
    // Puoi chiamare dei metodi GetX o aggiornare i contatori come desideri
    Get.find<TouchCounter>().incrementTouches();
  }

  void _handleScrollEvent() {
    // Logica per gestire l'evento di scroll
    print('Scroll event detected');
    // Puoi chiamare dei metodi GetX o aggiornare i contatori come desideri
    Get.find<ScrollCounter>().incrementScrolls();
  }
}
