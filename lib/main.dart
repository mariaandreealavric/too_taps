import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'controllers/Contatori/scroll_counter.dart';
import 'controllers/Contatori/touch_counter.dart';
import 'controllers/language_controller.dart';
import 'controllers/user_controller.dart';
import 'controllers/theme_controller.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'services/notification_service.dart';
import 'widgets/navigazione/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final notificationService = NotificationService();
  await notificationService.initialize();

  // Inizializza i controller
  Get.put(UserController());
  final userController = Get.find<UserController>();

  // Carica il profilo utente da Firebase
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  if (firebaseUser != null) {
    await userController.loadProfile(firebaseUser.uid);
  } else {
    print('Nessun utente autenticato.');
  }

  // Ottieni il profilo aggiornato dal controller
  final userProfile = userController.profile.value;

  if (userProfile != null) {
    // Inizializza i contatori con il profilo caricato da Firebase
    Get.put(ScrollCounter(userProfile));
    Get.put(TouchCounter(userProfile));
  } else {
    print('Errore: Profilo utente non disponibile.');
  }

  // Inizializza gli altri controller
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
    _initializeMethodChannel();

    return GetMaterialApp(
      title: 'TOO-Taps',
      locale: Get.locale ?? const Locale('en', 'US'),
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
    print('Touch event detected');
    Get.find<TouchCounter>().incrementTouches();
  }

  void _handleScrollEvent() {
    print('Scroll event detected');
    Get.find<ScrollCounter>().incrementScrolls();
  }
}
