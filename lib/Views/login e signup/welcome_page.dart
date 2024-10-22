import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_taps/Views/login%20e%20signup/signup_name.dart';
import 'package:too_taps/Views/login%20e%20signup/signup_page.dart';
import 'package:too_taps/controllers/theme_controller.dart';

import '../../Widgets/lenguageMenu_widget.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      extendBodyBehindAppBar: true, // Per estendere il corpo dietro l'appBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Sfondo coerente con il resto dell'app
          Positioned.fill(
            child: Container(
              decoration: themeController.boxDecoration,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Menu di selezione della lingua
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: LanguageMenu(),
                ),

                const Spacer(),

                // Logo al centro
                Image.asset(
                  'assets/main_logo.png', // Assicurati che il percorso del logo sia corretto
                  height: 120,
                ),

                const SizedBox(height: 50),

                // Testo di benvenuto
                Text(
                  'welcome_to_tootaps'.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'KeplerStd',
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // Testo informativo
                Text(
                  'sign_in_or_create_account'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'PlusJakartaSans',
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Pulsanti
                Column(
                  children: [
                    // Bottone Accedi
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const LoginPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'log_in'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Bottone Crea un nuovo account
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const SignUpPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue[100],
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'create_new_account'.tr,
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
