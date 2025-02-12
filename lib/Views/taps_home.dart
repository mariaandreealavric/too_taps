import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';

import '../Widgets/Navigazione/navigazione.dart';
import '../Widgets/unreal_widget.dart';
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

    final themeController = Get.find<ThemeController>();
    final profileController = Get.find<ProfileController>(); // GetX ProfileController
    final scrollCounter = Get.find<ScrollCounter>(); // Usa GetX per il ScrollCounter
    final touchCounter = Get.find<TouchCounter>(); // Usa GetX per il TouchCounter

    if (profileController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    final profile = profileController.profile.value;

    if (profile == null) {
      return const Center(child: CircularProgressIndicator());
    }

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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Taps',
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
                  child: const UnrealWidget(), // Mostra Unreal Engine invece dell'immagine
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 80), // Spazio per l'AppBar trasparente
                  GestureDetector(
                    onTap: () {
                      touchCounter.incrementTouches();
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
                                _selectedIndex = index;
                              });
                              touchCounter.incrementTouches();
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    index == _selectedIndex
                                        ? _images[1]
                                        : _images[0],
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
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Obx(() {
                          return RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Taps',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 80,
                                    fontFamily: 'KeplerStd',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: '\n${touchCounter.touches.value}',
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
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Navigation(profile: profile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
