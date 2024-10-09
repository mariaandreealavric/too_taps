import 'package:flutter/material.dart';

class RedFollowButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RedFollowButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.red, // Colore rosso per il bottone
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      onPressed: onPressed,
      child: const Text(
        'Segui',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'KeplerStd',
        ),
      ),
    );
  }
}