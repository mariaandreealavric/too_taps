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
          left: circlePosition - 21, // Centra il dock_circle con l'icona
          bottom: Tween<double>(
            begin: 0,
            end: dockCircleAnimation.value,
          ).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Curves.decelerate, // Usa una curva che rallenta alla fine per maggiore fluidità
            ),
          ).value,
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: animationController,
              curve: Curves.easeInOut, // Sfumatura graduale per rendere meno visibile lo "scatto"
            ),
            child: TweenAnimationBuilder<Color?>(
              duration: const Duration(milliseconds: 500), // Durata maggiore per animazione più fluida
              tween: ColorTween(
                begin: Colors.transparent, // Colore iniziale
                end: circleColors[selectedIndex], // Colore selezionato
              ),
              curve: Curves.easeInOut, // Migliora la fluidità del cambio di colore
              builder: (context, color, child) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color, // Cambia colore in base all'indice selezionato
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
