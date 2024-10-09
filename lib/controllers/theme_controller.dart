// controllers/theme_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _boxDecoration = const BoxDecoration(
    color: Color.fromRGBO(0, 0, 0, 0.89), // Nero puro

  ).obs;
  final _shadowColor = Colors.blue.withOpacity(0.4).obs;
  final _currentTheme = ThemeData.light().obs;
  final _listTileColor = Colors.blue.obs;

  ThemeData get currentTheme => _currentTheme.value;
  Color get shadowColor => _shadowColor.value;
  BoxDecoration get boxDecoration => _boxDecoration.value;
  Color get listTileColor => _listTileColor.value;

  void switchTheme() {
    if (_currentTheme.value == ThemeData.light()) {
      _currentTheme.value = ThemeData.dark();
      _boxDecoration.value = const BoxDecoration(
        color: Color.fromARGB(29, 29, 27, 0),
        gradient: LinearGradient(
          colors: [Colors.black, Colors.red],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );
    } else {
      _currentTheme.value = ThemeData.light();
      _boxDecoration.value = const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.89),

      gradient: LinearGradient(
          colors: [Colors.black, Colors.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );
      _listTileColor.value = Colors.blue;
    }
    _shadowColor.value = _listTileColor.value.withOpacity(0.4);
  }
}
