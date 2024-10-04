// widgets/navigazione/route_generator.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Views/challenge.dart';
import '../../Views/home_page.dart';
import '../../Views/pod.dart';
import '../../Views/profilo.dart';
import '../../Views/scrolling.dart';
import '../../Views/taps_home.dart';


class RouteGenerator {
  // Lista delle pagine definite come static
  static final List<GetPage<dynamic>> getPages = [
    GetPage(
      name: '/',
      page: () => const HomePage(),
    ),
    GetPage(
      name: '/taps_home',
      page: () => const TapsHomePage(userID: 'default_user_id'),
    ),
    GetPage(
      name: '/scrolling',
      page: () => const ScrollingPage(userID: 'default_user_id'),
    ),
    GetPage(
      name: '/pod',
      page: () => const PodPage(),
    ),
    GetPage(
      name: '/profilo',
      page: () => const ProfilePage(userID: 'default_user_id'),
    ),
    GetPage(
      name: '/challenge',
      page: () => const ChallengePage(userID: 'default_user_id'),
    ),
  ];

  // Questo metodo gestisce eventuali errori di routing
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ERROR: Route not found'),
          ),
        );
      },
    );
  }
}
