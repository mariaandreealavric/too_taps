import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/Contatori/touch_counter.dart';

class NavigationIconsRow extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final TouchController touchController;
  final List<Color> circleColors;
  final AnimationController animationController;
  final Animation<double> dockCircleAnimation;
  final double circlePosition;

  const NavigationIconsRow({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.touchController,
    required this.circleColors,
    required this.animationController,
    required this.dockCircleAnimation,
    required this.circlePosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Cerchio animato colorato sotto l'icona selezionata
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Positioned(
              left: circlePosition - 30, // Centra il dock_circle con l'icona
              bottom: dockCircleAnimation.value, // Anima l'altezza del cerchio verso l'alto
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: circleColors[selectedIndex], // Cambia colore in base all'indice selezionato
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
        // Icone di navigazione
        SizedBox(
          height: 104,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                inactiveImage: 'assets/sezione_tap.png',
                activeImage: 'assets/sezione_tap_active.png',
                index: 0,
              ),
              _buildNavItem(
                inactiveImage: 'assets/sezione_scroll.png',
                activeImage: 'assets/sezione_scroll_active.png',
                index: 1,
              ),
              _buildNavItem(
                inactiveImage: 'assets/sezione_pod.png',
                activeImage: 'assets/sezione_pod_active.png',
                index: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required String inactiveImage,
    required String activeImage,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        if (selectedIndex != index) {
          onItemTapped(index);
          touchController.incrementTouches();
          animationController.forward(); // Avvia l'animazione solo se cambia il bottone selezionato
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(
                  0, selectedIndex == index ? -10 : 0, 0),
              child: Image.asset(
                selectedIndex == index ? activeImage : inactiveImage,
                width: 36.0,
                height: 36.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
