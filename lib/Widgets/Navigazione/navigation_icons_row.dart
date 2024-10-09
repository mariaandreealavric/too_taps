import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/Contatori/navigation_controller.dart';
import '../../controllers/Contatori/touch_counter.dart';

class NavigationIconsRow extends StatelessWidget {
  final TouchController touchController;
  final List<Color> circleColors;
  final AnimationController animationController;
  final Animation<double> dockCircleAnimation;
  final double circlePosition;

  NavigationIconsRow({
    Key? key,
    required this.touchController,
    required this.circleColors,
    required this.animationController,
    required this.dockCircleAnimation,
    required this.circlePosition,
  }) : super(key: key);

  final NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Permette l'overflow
      children: [
        // Icone di navigazione
        SizedBox(
          height: 60,
          width: double.infinity,
          child: Obx(
                () => Row(
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
        if (navigationController.selectedIndex.value != index) {
          navigationController.navigateToPage(index);
          touchController.incrementTouches();
          animationController.forward(); // Avvia l'animazione senza tornare all'inizio
        }
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0,
          end: navigationController.selectedIndex.value == index ? -10 : 0,
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutSine, // Utilizza una curva più morbida per un'animazione naturale
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutSine, // Sincronizza la curva per una transizione più morbida
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Image.asset(
                navigationController.selectedIndex.value == index ? activeImage : inactiveImage,
                width: 24.0,
                height: 24.0,
              ),
            ),
          );
        },
      ),
    );
  }
}