import 'package:get/get.dart';
import '../models/profile_model.dart';
import '../services/challenge_service.dart';

class ChallengeController extends GetxController {
 // final ChallengeService _challengeService = ChallengeService();
  DateTime? _startTime;
  ProfileModel? _challenger;
  ProfileModel? _opponent;

  var isChallengeOngoing = false.obs; // Usa RxBool per la reattività

  DateTime? get startTime => _startTime;
  ProfileModel? get challenger => _challenger;
  ProfileModel? get opponent => _opponent;

  void startChallenge(ProfileModel challenger, ProfileModel opponent) {
    _challenger = challenger;
    _opponent = opponent;
    _startTime = DateTime.now();
 //   _challengeService.startChallenge(challenger, opponent);
    isChallengeOngoing.value = true; // Aggiorna lo stato reattivo
  }

  Future<void> completeChallenge() async {
  //  await _challengeService.completeChallenge();
    _challenger = null;
    _opponent = null;
    _startTime = null;
    isChallengeOngoing.value = false; // Aggiorna lo stato reattivo
  }

  bool isChallengeCompleted() {
    if (_startTime == null) return false;
    return DateTime.now().isAfter(_startTime!.add(const Duration(days: 7)));
  }
}
