import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  final double width;
  final double circlePosition;

  const NavigationBarWidget({
    Key? key,
    required this.width,
    required this.circlePosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ingrandisci la larghezza della dockbar del 50%
    final double newWidth = width * 3.0;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: circlePosition - (newWidth / 2),
      bottom: 0,
      child: Image.asset(
        'assets/dockbarlong.png',
        width: newWidth,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}