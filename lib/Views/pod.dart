import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_taps/Widgets/pod%20widgets/pod_appbar.dart';
import 'package:too_taps/Widgets/pod%20widgets/recap.dart';
import 'package:too_taps/Widgets/pod%20widgets/reward_widget.dart';
import 'package:too_taps/Widgets/pod%20widgets/suggested_profile_widget.dart';
import '../Widgets/Navigazione/navigazione.dart';
import '../controllers/profile_controller.dart';
import '../controllers/theme_controller.dart'; // Usa il percorso coerente per il controller

class PodPage extends StatelessWidget {
  const PodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final themeController = Get.find<ThemeController>();
    final profile = profileController.profile.value;

    if (profile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      extendBodyBehindAppBar: true, // Estende il corpo dietro l'AppBar per renderla trasparente
      body: Stack(
        children: [
          Container(
            decoration: themeController.boxDecoration,
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  CustomPodAppBar(profile: profile),
                  const RewardWidget(),
                  const SuggestedProfileWidget(userName: 'Monica Neri', jobTitle: 'ristoratrice', profileImageUrl: 'photoUrl', postImageUrl: 'postImageUrl'),
                  const RecapWidget(),
                  const SuggestedProfileWidget(userName: 'Antonio Ratto', jobTitle: 'Programmatore', profileImageUrl: 'photoUrl', postImageUrl: 'postImageUrl'),
                  const SizedBox(height: 100), // Spazio per evitare che il contenuto si sovrapponga alla barra di navigazione
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Navigation(profile: profile), // Barra di navigazione fissa in basso
          ),
        ],
      ),
    );
  }
}
