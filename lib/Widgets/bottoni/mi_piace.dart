import 'package:flutter/material.dart';

class MiPiace extends StatefulWidget {
  const MiPiace({super.key});

  @override
  State<MiPiace> createState() => _MiPiaceState();
}

class _MiPiaceState extends State<MiPiace> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        size: 36.0,
        color: isFavorite ? Colors.red : Colors.black,
      ),
    );
  }
}
