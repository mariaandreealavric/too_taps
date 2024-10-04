import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';

import '../Widgets/Navigazione/navigazione.dart';
import '../controllers/profile_controller.dart';
import '../controllers/theme_controller.dart'; // Import the GetX ThemeController

class TapsHomePage extends StatefulWidget {
  final String userID;

  const TapsHomePage({super.key, required this.userID});

  @override
  TapsHomePageState createState() => TapsHomePageState();
}

class TapsHomePageState extends State<TapsHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isWelcomeMessageShown = false;
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

 // Future<void> _signOut() async {
  //  await FirebaseAuth.instance.signOut();
  //  if (mounted) {
  //    Get.offAllNamed('/'); // Use GetX for navigation after sign out
 //   }
 // }

  @override
  Widget build(BuildContext context) {
    _logger.i('TapsHomePage: Building with userID ${widget.userID}');

    // Use GetX for ThemeController
    final themeController = Get.find<ThemeController>();
    final profileController = Get.find<ProfileController>(); // GetX ProfileController

    // Controlla lo stato di caricamento del profilo
    if (profileController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    final profile = profileController.profile.value; // Usa .value per accedere al ProfileModel

    // Se il profilo non è caricato, mostra un indicatore di caricamento
    if (profile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_isWelcomeMessageShown) {
      _isWelcomeMessageShown = true;
      _showWelcomeSnackbar(profile.displayName); // Accedi a displayName tramite profile
    }

    return GestureDetector(
      onTap: () {
        if (mounted) {
          profileController.incrementTouches(); // Usa il metodo del controller GetX
          profileController.incrementScrolls();   // Un altro metodo del controller GetX
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,  // Estende il corpo dietro l'AppBar per renderla trasparente
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,  // Centro il titolo
          title: const Text( // Usa il parametro "title" dell'AppBar
            'Taps', // Scritta in piccolo "Taps"
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: 'KeplerStd', // Nome della famiglia del font come specificato in pubspec.yaml
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

        body: Container(
          decoration: themeController.boxDecoration, // Usa il GetX controller per la gestione del tema
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  const SizedBox(height: 60), // Spazio per l'AppBar trasparente
                  // Aggiunta dei segnaposto scrollabili
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8, // 8 segnaposto
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index; // Aggiorna l'indice selezionato
                            });
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
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight, // Fissa il contenuto in basso a destra
                      child: Padding(
                        padding: const EdgeInsets.all(16.0), // Aggiunge un po' di padding se necessario
                        child: RichText(
                          textAlign: TextAlign.right, // Allinea il testo a destra
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Taps', // Testo prima di andare a capo
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 80,
                                  fontFamily: 'KeplerStd', // Nome della famiglia del font come specificato in pubspec.yaml
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: '\n${profile.touches}', // A capo con il numero dei tocchi
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 80,
                                  fontFamily: 'PlusJakartaSans', // Nome della famiglia del font come specificato in pubspec.yaml
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: constraints.maxWidth,
                    color: Colors.transparent,
                    child: Navigation(profile: profile), // Passa l'argomento profile
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
