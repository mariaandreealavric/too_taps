import 'package:flutter/material.dart';

class DockCircleWidget extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> dockCircleAnimation;
  final double circlePosition;
  final int selectedIndex;
  final List<Color> circleColors;
  final String Function(int) getActiveImage;

  const DockCircleWidget({
    Key? key,
    required this.animationController,
    required this.dockCircleAnimation,
    required this.circlePosition,
    required this.selectedIndex,
    required this.circleColors,
    required this.getActiveImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Positioned(
          left: circlePosition - 30, // Centra il dock_circle con l'icona
          bottom: dockCircleAnimation.value, // Anima l'altezza del cerchio verso l'alto
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: circleColors[selectedIndex], // Cambia colore in base all'indice selezionato
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                getActiveImage(selectedIndex),
                width: 36,
                height: 36,
              ),
            ),
          ),
        );
      },
    );
  }
}
