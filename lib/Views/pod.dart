import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/Navigazione/navigazione.dart';
import '../controllers/profile_controller.dart';
import '../controllers/theme_controller.dart'; // Usa il percorso coerente per il controller

class PodPage extends StatelessWidget {
  const PodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      extendBodyBehindAppBar: true,  // Estende il corpo dietro l'AppBar per renderla trasparente
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        centerTitle: true, // Centro il titolo
        title: const Text(
          'Pod', // Scritta in piccolo "Pod"
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: themeController.boxDecoration,
        child: Column(
          children: [
            const Expanded( // Usa Expanded per riempire lo spazio disponibile
              child: Center(
                child: Text(
                  'Il tuo Pod sta arrivando!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Obx(() {
              final profile = profileController.profile.value;
              if (profile == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Navigation(profile: profile); // Barra di navigazione in basso
              }
            }),
          ],
        ),
      ),
    );
  }
}
