import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';
import '../../models/profile_model.dart';

class CustomPodAppBar extends StatelessWidget {
  final ProfileModel profile;

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
          // Parte sinistra: CircleAvatar, nome utente e job title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome in the Pod',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'KeplerStd', // Assicurati che il font sia specificato in pubspec.yaml
                ),
              ),
              const SizedBox(height: 8),
              Text(
                userProfile.displayName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                userProfile.jobTitle,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.red,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(userProfile.photoUrl),
                ),
              ),
            ],
          ),
          // Parte destra: Espansione e allineamento
          const Expanded(
            child: Align(
              alignment: Alignment.topRight,
            ),
          ),
        ],
      ),
    );
  }
}
