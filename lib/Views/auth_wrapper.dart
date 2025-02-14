import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import 'auth_check.dart';
import 'home_page.dart';


// Definisce un widget stateless chiamato AuthWrapper
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key}); // Costruttore del widget, accetta una chiave opzionale

  @override
  Widget build(BuildContext context) {
    // Usa GetX per trovare un'istanza di ProfileController che è stata precedentemente inizializzata
    final profileController = Get.find<UserController>();

    // Usa AuthCheck per determinare se un utente è autenticato
    return AuthCheck(
      builder: (context, userID) {
        // Se l'utente è autenticato, restituisce HomePage; altrimenti, puoi gestire la logica di fallback in AuthCheck
        return const HomePage();
      },
    );
  }
}
