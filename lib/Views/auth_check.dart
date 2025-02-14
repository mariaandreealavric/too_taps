import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/user_controller.dart';

class AuthCheck extends StatefulWidget {
  final Widget Function(BuildContext, String?) builder;

  const AuthCheck({super.key, required this.builder});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final Logger _logger = Logger();
  final UserController profileController = Get.find<UserController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    _logger.i('Debug: Initializing profile...');

    User? user = _auth.currentUser; // Ottieni l'utente autenticato
    if (user != null) {
      await profileController.loadProfile(user.uid); // Carica il profilo da Firebase Firestore
      _logger.i('Profile loaded for user: ${user.uid}');
    } else {
      _logger.w('No authenticated user found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _auth.currentUser?.uid);
  }
}
