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
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: circlePosition - (width / 2),
      bottom: 0,
      child: Image.asset(
        'assets/dockbar.png',
        width: width,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
