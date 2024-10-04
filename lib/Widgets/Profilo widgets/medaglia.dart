import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/theme_controller.dart'; // Importa GetX

class Medaglia extends StatelessWidget {
  const Medaglia({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>(); // Usa GetX per ottenere il controller

    return CircleAvatar(
      radius: 30,
      child: Icon(
        Icons.emoji_events,
        color: Colors.yellow[700],
        size: 30,
      ),
    );
  }
}
