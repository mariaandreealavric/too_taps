import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/challenge_controller.dart';
import '../../models/profile_model.dart'; // Assicurati di importare il controller giusto

class ChallengeButton extends StatelessWidget {
  final ProfileModel challenger;
  final ProfileModel opponent;

  const ChallengeButton({super.key, required this.challenger, required this.opponent});

  @override
  Widget build(BuildContext context) {
    final challengeController = Get.find<ChallengeController>(); // Usa GetX per ottenere l'istanza del controller

    return Obx(() { // Usa Obx per aggiornare l'UI automaticamente quando cambia lo stato
      bool isOngoing = challengeController.isChallengeOngoing.value; // Usa .value per ottenere il valore di RxBool

      return IconButton(
        icon: Icon(
          Icons.sports_kabaddi,
          color: isOngoing ? Colors.red : Colors.white,
        ),
        onPressed: () {
          if (!isOngoing) {
            challengeController.startChallenge(challenger, opponent);

            // Pianifica il completamento della sfida dopo 7 giorni
            Future.delayed(const Duration(days: 7), () async {
              await challengeController.completeChallenge();
              if (challengeController.isChallengeCompleted()) {
                // Aggiorna lo stato o notifica l'UI come necessario
              }
            });
          }
        },
      );
    });
  }
}
