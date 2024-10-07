import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/Contatori/navigation_controller.dart';
import '../../controllers/Contatori/touch_counter.dart';
import '../../models/profile_model.dart';
import 'dock_circle_widget.dart';
import 'navigation_bar_widget.dart';
import 'navigation_icons_row.dart';

class Navigation extends StatefulWidget {
  final ProfileModel profile;

  const Navigation({super.key, required this.profile});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin {

  // AnimationController per animare il dock circle
  late AnimationController _animationController;
  late Animation<double> _dockCircleAnimation;

  // Posizioni orizzontali relative per le icone
  final List<double> positions = [
    0.17, // Posizione del primo pulsante
    0.5, // Posizione del secondo pulsante (centro)
    0.83, // Posizione del terzo pulsante
  ];

  // Colori corrispondenti alle icone selezionate
  final List<Color> circleColors = [
    Colors.yellow, // Colore per il primo pulsante
    Colors.blue,   // Colore per il secondo pulsante
    Colors.red,    // Colore per il terzo pulsante
  ];

  final NavigationController navigationController = Get.put(NavigationController());

  @override
  void initState() {
    super.initState();

    // Inizializza l'AnimationController
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Definisci l'animazione per il dock circle
    _dockCircleAnimation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Avvia l'animazione all'inizio
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final touchController = Get.put(TouchController(widget.profile));
    double width = MediaQuery.of(context).size.width;

    // Calcola la posizione orizzontale del dock circle
    double circlePosition = width * positions[navigationController.selectedIndex.value];

    return Obx(() => SizedBox(
      height: 70, // Altezza totale del widget di navigazione
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Dockbar animata
          NavigationBarWidget(
            circlePosition: circlePosition,
            width: width * 1.2, // Estendi la dockbar oltre i bordi laterali
          ),
          // Dock circle animato
          DockCircleWidget(
            animationController: _animationController,
            dockCircleAnimation: _dockCircleAnimation,
            circlePosition: circlePosition,
            selectedIndex: navigationController.selectedIndex.value,
            circleColors: circleColors,
            getActiveImage: _getActiveImage,
          ),
          // Barra di navigazione statica (icone statiche)
          NavigationIconsRow(
            touchController: touchController,
            circleColors: circleColors,
            animationController: _animationController,
            dockCircleAnimation: _dockCircleAnimation,
            circlePosition: circlePosition,
          ),
        ],
      ),
    ));
  }

  // Ottiene l'immagine attiva in base all'indice selezionato
  String _getActiveImage(int index) {
    switch (index) {
      case 0:
        return 'assets/sezione_tap_active.png';
      case 1:
        return 'assets/sezione_scroll_active.png';
      case 2:
        return 'assets/sezione_pod_active.png';
      default:
        return '';
    }
  }
}