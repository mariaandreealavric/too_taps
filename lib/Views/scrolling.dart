import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX
import 'package:logger/logger.dart';
import '../controllers/Contatori/scroll_counter.dart';
import '../controllers/Contatori/touch_counter.dart';
import '../controllers/theme_controller.dart';
import '../widgets/Navigazione/navigazione.dart'; // Importa Navigation
import '../widgets/title_widget.dart'; // Importa TitleWidget
import '../controllers/user_controller.dart';

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
      Get.find<ScrollCounter>().incrementScrolls(); // Incrementa scroll tramite GetX
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
    final profileController = Get.find<UserController>(); // Usa GetX per il ProfileController
    final scrollCounter = Get.find<ScrollCounter>(); // Usa GetX per il ScrollCounter
    final touchCounter = Get.find<TouchCounter>(); // Usa GetX per il TouchCounter

    // Controlla se il profilo è caricato
    if (profileController.profile.value == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final profile = profileController.profile.value!; // Ottieni il profilo dal ProfileController

    return GestureDetector(
      onTap: () {
        touchCounter.incrementTouches(); // Incrementa tap tramite GetX
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification ||
              scrollNotification is ScrollUpdateNotification ||
              scrollNotification is ScrollEndNotification) {
            scrollCounter.incrementScrolls();
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/space.png', // Percorso dell'immagine
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true, // Centro il titolo
                    title: const Text(
                      'Scrolling', // Scritta "Scrolling"
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'KeplerStd',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight, // Fissa il contenuto in basso a destra
                      child: Padding(
                        padding: const EdgeInsets.all(16.0), // Aggiunge un po' di padding se necessario
                        child: Obx(() {
                          return RichText(
                            textAlign: TextAlign.right, // Allinea il testo a destra
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Scrolling', // Testo prima di andare a capo
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 80,
                                    fontFamily: 'KeplerStd',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: '\n${scrollCounter.scrolls}', // A capo con il numero degli scroll
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,
                                    fontFamily: 'PlusJakartaSans',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Navigation(profile: profile), // Barra di navigazione fissa in basso
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
