import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_taps/Widgets/pod%20widgets/pod_appbar.dart';
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
      extendBodyBehindAppBar: true, // Estende il corpo dietro l'AppBar per renderla trasparente
      body: Obx(() {
        final profile = profileController.profile.value;
        if (profile == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            Container(
              decoration: themeController.boxDecoration,
            ),
            Column(
              children: [
                // Contenuto principale con CustomPodAppBar
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomPodAppBar(profile: profile),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        final profile = profileController.profile.value;
        if (profile == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Navigation(profile: profile); // Barra di navigazione in basso
        }
      }),
    );
  }
}
