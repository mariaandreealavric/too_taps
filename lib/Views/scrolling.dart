import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX
import '../controllers/Contatori/scroll_counter.dart';
import '../controllers/Contatori/touch_counter.dart';
import '../widgets/Navigazione/navigazione.dart';
import '../controllers/user_controller.dart';
import '../controllers/scroll_analysis_controller.dart';

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
  late StreamController<double> _scrollStreamController;
  final String distanceUnit = "meters";

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
    final profileController = Get.find<UserController>();
    final scrollCounter = Get.find<ScrollCounter>();
    final touchCounter = Get.find<TouchCounter>();

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
                  'assets/space.png',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    title: const Text(
                      'Scrolling',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'KeplerStd',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const _ScrollStageView(),
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
                                  text: 'Scrolling',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 80,
                                    fontFamily: 'KeplerStd',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: '\n${scrollCounter.scrolls}',
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

class _ScrollStageView extends StatelessWidget {
  const _ScrollStageView();

  @override
  Widget build(BuildContext context) {
    final analysisController = Get.find<ScrollAnalysisController>();
    return Obx(() {
      final stage = analysisController.currentStage.value;
      final distance = analysisController.currentDistanceMeters;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.55),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: stage.accentColor.withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stage.title,
              style: TextStyle(
                color: stage.accentColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              stage.subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Distanza registrata: ${distance.toStringAsFixed(0)} m',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Placeholder vista 3D Unreal',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cue scena: ${stage.unrealCue}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Il modello 3D si fermerà su questo layer.',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
