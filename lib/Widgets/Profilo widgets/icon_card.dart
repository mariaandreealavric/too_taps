import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  final IconData icon;
  final String value;

  const IconCard({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 50, color: Colors.blue),
        const SizedBox(height: 20),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
