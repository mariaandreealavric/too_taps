import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_taps/Widgets/pod%20widgets/pod_appbar.dart';
import 'package:too_taps/Widgets/pod%20widgets/recap.dart';
import 'package:too_taps/Widgets/pod%20widgets/reward_widget.dart';
import 'package:too_taps/Widgets/pod%20widgets/suggested_profile_widget.dart';
import '../Widgets/Navigazione/navigazione.dart';
import '../controllers/Contatori/scroll_counter.dart';
import '../controllers/Contatori/touch_counter.dart';
import '../controllers/profile_controller.dart';
import '../controllers/theme_controller.dart';
import '../models/mock_models.dart'; // Usa il percorso coerente per il controller

class PodPage extends StatelessWidget {
  const PodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final profileController = Get.find<ProfileController>();
    final scrollCounter = Get.find<ScrollCounter>();
    final touchCounter = Get.find<TouchCounter>();

    final mockProfile = MockProfileModel();

    return GestureDetector(
      onTap: () {
        // Incrementa i tocchi tramite GetX
        touchCounter.incrementTouches();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          // Incrementa il contatore ogni volta che c'è uno scroll
          if (scrollNotification is ScrollStartNotification ||
              scrollNotification is ScrollUpdateNotification ||
              scrollNotification is ScrollEndNotification) {
            scrollCounter.incrementScrolls();
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
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
                      CustomPodAppBar(profile: mockProfile),
                      const RewardWidget(),
                      SuggestedProfileWidget(
                        profile: getRandomProfile(), // Passa un profilo casuale
                      ),
                      const RecapWidget(),
                      SuggestedProfileWidget(
                        profile: getRandomProfile(), // Passa un profilo casuale
                      ),
                      const SizedBox(height: 100), // Spazio per evitare che il contenuto si sovrapponga alla barra di navigazione
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Navigation(profile: mockProfile), // Barra di navigazione fissa in basso
              ),
            ],
          ),
        ),
      ),
    );
  }
}
