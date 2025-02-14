import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX
import '../controllers/challenge_controller.dart';
import '../controllers/user_controller.dart'; // Importa ProfileController

class ChallengePage extends StatelessWidget {
  final String userID;

  const ChallengePage({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    // Ottieni l'istanza di ProfileController e ChallengeController usando GetX
    final profileController = Get.find<UserController>();
    final challengeController = Get.find<ChallengeController>(); // Supponiamo che ChallengeController utilizzi anche GetX

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sfide'),
      ),
      body: Obx(() {
        // Usa Obx per osservare i cambiamenti nello stato di profileController
        if (profileController.profile.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Controlla la lista delle sfide
        final challenges = profileController.profile.value!.challenges;
        return ListView.builder(
          itemCount: challenges.length,
          itemBuilder: (context, index) {
            final challenge = challenges[index];
            final isChallenger = challenge['challengerUid'] == userID;
            final opponentUid = isChallenger ? challenge['opponentUid'] : challenge['challengerUid'];
            final opponentTouches = isChallenger ? challenge['opponentTouches'] : challenge['challengerTouches'];
            final opponentScrolls = isChallenger ? challenge['opponentScrolls'] : challenge['challengerScrolls'];
            final userTouches = isChallenger ? challenge['challengerTouches'] : challenge['opponentTouches'];
            final userScrolls = isChallenger ? challenge['challengerScrolls'] : challenge['opponentScrolls'];

            return ListTile(
              title: Text('Sfida con $opponentUid'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Inizio: ${challenge['startDate'].toDate()} - Fine: ${challenge['endDate'].toDate()}'),
                  Text('I tuoi tocchi: $userTouches, I tuoi scrolls: $userScrolls'),
                  Text('Tocchi avversario: $opponentTouches, Scrolls avversario: $opponentScrolls'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () async {
                  await challengeController.completeChallenge(); // Supponiamo che questo sia un metodo nel ChallengeController
                  profileController.loadProfile(userID);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
