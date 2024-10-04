import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX

import '../../Views/profilo.dart';
import '../../controllers/Contatori/touch_counter.dart';

class ProfileButton extends StatefulWidget {
  const ProfileButton({super.key});

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  void _incrementTouchCount() {
    final touchController = Get.find<TouchController>(); // Usa GetX per ottenere il controller
    touchController.incrementTouches(); // Incrementa il conteggio dei tocchi
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(right: 50),
      child: GestureDetector(
        onTap: _incrementTouchCount,
        child: IconButton(
          onPressed: () {
            Get.to(() => const ProfilePage(userID: '')); // Usa GetX per la navigazione
          },
          icon: const Icon(
            Icons.person_3,
            size: 36.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
