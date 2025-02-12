import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';

import '../Widgets/Navigazione/navigazione.dart';
import '../controllers/Contatori/scroll_counter.dart';
import '../controllers/Contatori/touch_counter.dart';
import '../controllers/profile_controller.dart';
import '../controllers/theme_controller.dart';

class TapsHomePage extends StatefulWidget {
  final String userID;

  const TapsHomePage({super.key, required this.userID});

  @override
  TapsHomePageState createState() => TapsHomePageState();
}

class TapsHomePageState extends State<TapsHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
 // bool _isWelcomeMessageShown = false;
  int _selectedIndex = 0; // Indice del segnaposto selezionato
  final Logger _logger = Logger(); // Instance of Logger

  final List<String> _images = [
    'assets/statua_invalid.png', // Percorso dell'immagine inattiva
    'assets/statua_attiva.png',  // Percorso dell'immagine attiva
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showWelcomeSnackbar(String userName) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Get.snackbar(
          'Welcome',
          'Welcome, $userName',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 1),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _logger.i('TapsHomePage: Building with userID ${widget.userID}');

    // Use GetX for ThemeController
    final themeController = Get.find<ThemeController>();
    final profileController = Get.find<ProfileController>(); // GetX ProfileController
    final scrollCounter = Get.find<ScrollCounter>(); // Usa GetX per il ScrollCounter
    final touchCounter = Get.find<TouchCounter>(); // Usa GetX per il TouchCounter

    // Controlla lo stato di caricamento del profilo
    if (profileController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    final profile = profileController.profile.value;

    // Se il profilo non è caricato, mostra un indicatore di caricamento
    if (profile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    /*if (!_isWelcomeMessageShown) {
      _isWelcomeMessageShown = true;
      _showWelcomeSnackbar(profile.displayName); // Accedi a displayName tramite profile
    }*/

    return GestureDetector(
      onTap: () {
        touchCounter.incrementTouches(); // Incrementa il contatore dei tap
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
          extendBodyBehindAppBar: true, // Estende il corpo dietro l'AppBar per renderla trasparente
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            centerTitle: true, // Centro il titolo
            title: const Text(
              'Taps', // Scritta in piccolo "Taps"
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'KeplerStd',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
              ),
            ),
            actions: const <Widget>[
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: null,
              ),
            ],
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    touchCounter.incrementTouches(); // Incrementa il contatore dei tap
                  },
                  //child: const UnrealWidget(), // Mostra Unreal Engine invece dell'immagine
                  child: Image.asset(
                    'assets/statue.png', // Percorso dell'immagine
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 80), // Spazio per l'AppBar trasparente
                  // Aggiunta dei segnaposto scrollabili
                  GestureDetector(
                    onTap: () {
                      touchCounter.incrementTouches(); // Incrementa il contatore dei tap
                    },
                    child: SizedBox(
                      height: 20,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 8, // 8 segnaposto
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index; // Aggiorna l'indice selezionato
                              });
                              touchCounter.incrementTouches(); // Incrementa il contatore dei tap
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              width: 60, // Dimensione del segnaposto
                              height: 60, // Dimensione del segnaposto
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    index == _selectedIndex
                                        ? _images[1] // Immagine attiva
                                        : _images[0], // Immagine inattiva
                                  ),
                                  fit: BoxFit.contain,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
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
                                  text: 'Taps', // Testo prima di andare a capo
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 80,
                                    fontFamily: 'KeplerStd',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: '\n${touchCounter.touches.value}', // A capo con il numero dei tocchi aggiornato dinamicamente
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 80,
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
