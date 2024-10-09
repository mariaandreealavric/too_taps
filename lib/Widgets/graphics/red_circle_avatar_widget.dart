import 'package:flutter/material.dart';

class RedCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double outerRadius;
  final double innerRadius;

  const RedCircleAvatar({
    Key? key,
    required this.imageUrl,
    this.outerRadius = 23,
    this.innerRadius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: outerRadius,
      backgroundColor: Colors.red,
      child: CircleAvatar(
        radius: innerRadius,
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}