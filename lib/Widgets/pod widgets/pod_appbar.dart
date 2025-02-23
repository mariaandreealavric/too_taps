import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_taps/Widgets/graphics/job_title_widget.dart';
import 'package:too_taps/Widgets/graphics/profile_name_widget.dart';
import 'package:too_taps/Widgets/graphics/red_circle_avatar_widget.dart';
import '../../controllers/user_controller.dart';
import '../../generated/l10n.dart';
import '../../models/user_model.dart';

class CustomPodAppBar extends StatelessWidget {
  final UserModel profile;

  const CustomPodAppBar({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfile = profile;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Parte sinistra: "Welcome in the Pod"
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).welcome_in_the,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'KeplerStd', // Assicurati che il font sia specificato in pubspec.yaml
                ),
              ),
              Text(
                'Pod.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'KeplerStd', // Assicurati che il font sia specificato in pubspec.yaml
                ),
              ),
            ],
          ),
          const Spacer(),
          // Parte destra: Nome utente, job title e CircleAvatar
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileName(userName: userProfile.displayName), // Passa il nome del profilo
                  JobTitle(jobTitle: userProfile.jobTitle), // Passa il job title del profilo
                ],
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/profilo'); // Naviga alla pagina del profilo
                },
                child: RedCircleAvatar(imageUrl: userProfile.photoUrl), // Passa l'URL dell'immagine
              ),
            ],
          ),
        ],
      ),
    );
  }
}
