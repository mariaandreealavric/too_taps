import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/Contatori/touch_counter.dart';
import '../../models/profile_model.dart';

class Navigation extends StatefulWidget {
  final ProfileModel profile;

  const Navigation({super.key, required this.profile});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  // AnimationController per animare il dock circle
  late AnimationController _animationController;
  late Animation<double> _dockCircleAnimation;

  // Posizioni orizzontali relative per le icone
  final List<double> positions = [
    0.1, // Posizione del primo pulsante
    0.5, // Posizione del secondo pulsante (centro)
    0.9, // Posizione del terzo pulsante
  ];

  @override
  void initState() {
    super.initState();

    // Inizializza l'AnimationController
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Definisci l'animazione per il dock circle
    _dockCircleAnimation = Tween<double>(begin: 0, end: -20).animate(
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Riavvia l'animazione del dock circle
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final touchController = Get.put(TouchController(widget.profile));
    double width = MediaQuery.of(context).size.width;

    // Calcola la posizione orizzontale del dock circle
    double circlePosition = width * positions[_selectedIndex];

    return SizedBox(
      height: 100, // Altezza totale del widget di navigazione
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Barra di navigazione
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80, // Altezza della barra di navigazione
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    inactiveImage: 'assets/sezione_tap.png',
                    activeImage: 'assets/sezione_tap_active.png',
                    index: 0,
                    touchController: touchController,
                  ),
                  _buildNavItem(
                    inactiveImage: 'assets/sezione_scroll.png',
                    activeImage: 'assets/sezione_scroll_active.png',
                    index: 1,
                    touchController: touchController,
                  ),
                  _buildNavItem(
                    inactiveImage: 'assets/sezione_pod.png',
                    activeImage: 'assets/sezione_pod_active.png',
                    index: 2,
                    touchController: touchController,
                  ),
                ],
              ),
            ),
          ),
          // Dock circle animato
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                bottom: 40 + _dockCircleAnimation.value,
                left: circlePosition - 30,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/dock_circle.png',
                      width: 60,
                      height: 60,
                    ),
                    Image.asset(
                      _getActiveImage(_selectedIndex),
                      width: 36,
                      height: 36,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
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

  // Costruisce gli elementi della navigazione
  Widget _buildNavItem({
    required String inactiveImage,
    required String activeImage,
    required int index,
    required TouchController touchController,
  }) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
        touchController.incrementTouches();
        // Aggiungi la navigazione alla pagina corrispondente se necessario
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mostra l'icona solo se non è selezionata
          if (_selectedIndex != index)
            Image.asset(
              inactiveImage,
              width: 36.0,
              height: 36.0,
            ),
          // Spazio per allineare verticalmente le icone
          SizedBox(height: _selectedIndex == index ? 36.0 : 0),
        ],
      ),
    );
  }
}
