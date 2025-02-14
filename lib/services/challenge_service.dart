
/*
import 'dart:async';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fingerfy/models/user_model.dart';

import 'package:fingerfy/Services/shared_preferences.dart';
//import 'package:firebase_auth/firebase_auth.dart';


class ChallengeService {
//  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 // final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferencesManager _prefsManager = SharedPreferencesManager();

  Future<void> startChallenge(ProfileModel challenger, ProfileModel opponent) async {
    DateTime startTime = DateTime.now();
    await _prefsManager.saveStartTime(startTime);

    final challenge = {
      'challengerUid': challenger.uid,
      'opponentUid': opponent.uid,
    //  'startDate': Timestamp.fromDate(startTime),
   //   'endDate': Timestamp.fromDate(startTime.add(const Duration(days: 7))),
      'challengerTouches': 0,
      'challengerScrolls': 0,
      'opponentTouches': 0,
      'opponentScrolls': 0,
      'winner': null,
    };

  //  await _firestore.collection('challenges').add(challenge);
  }

  Future<void> completeChallenge() async {
    DateTime? startTime = await _prefsManager.getStartTime();
    if (startTime != null) {
      DateTime endTime = startTime.add(const Duration(days: 7));
      if (DateTime.now().isAfter(endTime)) {
        await _prefsManager.removeStartTime();
      }
    }
  }

  Future<void> sendChallenge(String opponentUid) async {
 //   final user = _auth.currentUser;
//    if (user != null) {
      final now = DateTime.now();
      final challenge = {
      //  'challengerUid': user.uid,
        'opponentUid': opponentUid,
      //  'startDate': Timestamp.fromDate(now),
     //   'endDate': Timestamp.fromDate(now.add(const Duration(days: 7))),
        'challengerTouches': 0,
        'challengerScrolls': 0,
        'opponentTouches': 0,
        'opponentScrolls': 0,
        'winner': null,
      };
  //    await _firestore.collection('challenges').add(challenge);
    }
  }

  Future<void> updateChallengeData(String challengeId, int touches, int scrolls, bool isChallenger) async {
 //   final challengeRef = _firestore.collection('challenges').doc(challengeId);
  //  final challenge = await challengeRef.get();
  //  if (challenge.exists) {
   //   final data = challenge.data()!;
   //   if (isChallenger) {
   //     data['challengerTouches'] = touches;
    //    data['challengerScrolls'] = scrolls;
   //   } else {
    //    data['opponentTouches'] = touches;
    //    data['opponentScrolls'] = scrolls;
      }
   //   await challengeRef.update(data);
    }
  }

  Future<void> checkChallengeWinner(String challengeId) async {
 //   final challengeRef = _firestore.collection('challenges').doc(challengeId);
  //  final challenge = await challengeRef.get();
  //  if (challenge.exists) {
  //    final data = challenge.data()!;
      final now = DateTime.now();
   //   final endDate = (data['endDate'] as Timestamp).toDate();

      if (now.isAfter(endDate)) {
        final challengerTouches = data['challengerTouches'];
        final challengerScrolls = data['challengerScrolls'];
        final opponentTouches = data['opponentTouches'];
        final opponentScrolls = data['opponentScrolls'];

        final challengerScore = challengerTouches + challengerScrolls;
        final opponentScore = opponentTouches + opponentScrolls;

        String winner;
        if (challengerScore < opponentScore) {
          winner = data['challengerUid'];
        } else {
          winner = data['opponentUid'];
        }

      //  await challengeRef.update({'winner': winner});

      //  final userRef = _firestore.collection('users').doc(winner);
        final user = await userRef.get();
        if (user.exists) {
          final userData = user.data()!;
          final trophies = userData['trophyList'] as List<dynamic>;
          trophies.add('Trofeo Sfida 7 Giorni');
          await userRef.update({'trophyList': trophies});
        }
      }
    }
  }
}
*/