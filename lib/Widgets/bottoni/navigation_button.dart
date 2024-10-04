import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/Contatori/touch_counter.dart';

class NavigationButton extends StatefulWidget {
  final IconData icon;
  final int index;
  final String routeName;
  final bool isSelected;
  final Function onTap;
  final TouchController touchController;

  const NavigationButton({
    super.key,
    required this.icon,
    required this.index,
    required this.routeName,
    required this.isSelected,
    required this.onTap,
    required this.touchController,
  });

  @override
  _NavigationButtonState createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  // Definisce i colori per ogni stato selezionato
  final List<Color> _colors = [
    const Color(0xFFFFE500),  // Colore esadecimale per la prima icona (giallo)
    const Color(0xFF007BFF),  // Colore esadecimale per la seconda icona (blu)
    const Color(0xFFFF4343),  // Colore esadecimale per la terza icona (rosso)
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.index);
        widget.touchController.incrementTouches();
        Get.toNamed(widget.routeName);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Usa AnimatedContainer per animare il colore di sfondo
          AnimatedContainer(
            duration: const Duration(milliseconds: 300), // Durata dell'animazione del colore
            width: 60, // Dimensioni del cerchio
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.isSelected ? _colors[widget.index] : Colors.white, // Colore animato del cerchio
            ),
          ),
          Icon(
            widget.icon,
            size: 36.0,
            color: widget.isSelected ? Colors.white : Colors.black, // Cambia colore icona
          ),
        ],
      ),
    );
  }
}
