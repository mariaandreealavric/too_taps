import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX
// import 'package:cloud_firestore/cloud_firestore.dart'; // Commenta l'importazione di Firestore
import 'package:logger/logger.dart';
import '../controllers/Contatori/scroll_counter.dart';
import '../controllers/theme_controller.dart';
import '../widgets/Navigazione/navigazione.dart'; // Importa Navigation

import '../controllers/profile_controller.dart';

class ScrollingPage extends StatefulWidget {
  final String userID;

  const ScrollingPage({super.key, required this.userID});

  @override
  ScrollingPageState createState() => ScrollingPageState();
}

class ScrollingPageState extends State<ScrollingPage> {
  final ScrollController _scrollController = ScrollController();
  double _lastScrollPosition = 0.0;
  final List<Color> _itemColors = [];
  final double _itemHeight = 750.0;
  late StreamController<double> _scrollStreamController;
  final String distanceUnit = "meters";
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollPosition);
    _scrollController.addListener(_scrollListener);
    _addInitialItems();
    _scrollStreamController = StreamController<double>();
    _scrollController.addListener(() {
      _scrollStreamController.add(_scrollController.position.pixels);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollPosition);
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _scrollStreamController.close();
    super.dispose();
  }

  void _updateScrollPosition() {
    double currentScrollPosition = _scrollController.position.pixels;
    if (currentScrollPosition > _lastScrollPosition) {
      double distance = (currentScrollPosition - _lastScrollPosition) * 0.1 / 100.0;
      // Utilizza il metodo GetX per incrementare i scroll
      Get.find<ScrollCounter>().incrementScrolls();

      // Aggiorna anche i dati nel database Firestore (commentato per ora)
      // try {
      //   await FirebaseFirestore.instance.collection('users').doc(widget.userID).update({
      //     'scrolls': FieldValue.increment(distance.toInt()),
      //   });
      //   _logger.i('Dati di scorrimento aggiornati con successo.');
      // } catch (error) {
      //   _logger.e('Errore durante l\'aggiornamento dei dati di scorrimento: $error');
      // }
    }
    _lastScrollPosition = currentScrollPosition;
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      _addMoreItems();
    }
  }

  void _addInitialItems() {
    _itemColors.addAll(List.generate(10, (index) => _generateRandomColor()));
  }

  Color _generateRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  void _addMoreItems() {
    setState(() {
      _itemColors.addAll(List.generate(10, (index) => _generateRandomColor()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>(); // Usa GetX per il ThemeController
    final profileController = Get.find<ProfileController>(); // Usa GetX per il ProfileController
    final scrollCounter = Get.find<ScrollCounter>(); // Usa GetX per il ScrollCounter

    // Controlla se il profilo è caricato
    if (profileController.profile.value == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final profile = profileController.profile.value!; // Ottieni il profilo dal ProfileController

    return GestureDetector(
      onTap: () {
        profileController.incrementTouches();
        profileController.incrementScrolls();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: themeController.boxDecoration,
            ),
            Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    'Scroll Meter',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Hai percorso:\n${scrollCounter.scrolls} $distanceUnit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeController.currentTheme.brightness == Brightness.light ? Colors.blue : Colors.green,
                      fontSize: 40,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: _itemHeight,
                        color: _itemColors[index % _itemColors.length],
                        child: const ListTile(
                          title: Text(' '),
                        ),
                      );
                    },
                    itemCount: _itemColors.length,
                  ),
                ),
                // Aggiungi il widget Navigation con il profilo
                Navigation(profile: profile), // Passa il profilo al widget Navigation
              ],
            ),
          ],
        ),
      ),
    );
  }
}
