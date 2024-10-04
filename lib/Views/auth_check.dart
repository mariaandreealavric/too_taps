// views/auth_check.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../controllers/profile_controller.dart';
import '../models/mock_models.dart';

// Definisce un widget stateful chiamato AuthCheck
class AuthCheck extends StatefulWidget {
  // Definisce un costruttore che accetta una funzione di callback `builder` che restituisce un widget
  final Widget Function(BuildContext, String) builder;

  const AuthCheck({super.key, required this.builder});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

// Stato del widget AuthCheck
class _AuthCheckState extends State<AuthCheck> {
  final Logger _logger = Logger(); // Istanzia un Logger per il debug
  final ProfileController profileController = Get.find<ProfileController>(); // Ottiene l'istanza di ProfileController tramite GetX
  final MockAuthModel mockAuth = Get.find<MockAuthModel>(); // Ottiene l'istanza di MockAuthModel tramite GetX

  @override
  void initState() {
    super.initState();
    _initializeProfile(); // Inizializza il profilo utente quando il widget viene creato
  }

  // Metodo per inizializzare il profilo utente mock
  Future<void> _initializeProfile() async {
    _logger.i('Debug: Initializing profile...'); // Log di debug per l'inizio dell'inizializzazione
    await Future.delayed(Duration.zero); // Esegue l'inizializzazione asincrona (utile per le future implementazioni)
    profileController.setMockProfile(mockAuth.uid); // Imposta il profilo utente mock nel ProfileController
    _logger.i('Profile set for mock user: ${mockAuth.uid}'); // Log di debug per confermare che il profilo è stato impostato
  }

  @override
  Widget build(BuildContext context) {
    // Utilizza il `builder` fornito per costruire il widget in base all'ID dell'utente mock
    return widget.builder(context, mockAuth.uid);
  }
}