import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnrealWidget extends StatelessWidget {
  const UnrealWidget({Key? key}) : super(key: key);

  static const MethodChannel _channel = MethodChannel('flutter_unreal');

  static Future<void> shatterStatue() async {
    await _channel.invokeMethod('shatterStatue');
  }

  static Future<void> changeStatue() async {
    await _channel.invokeMethod('changeStatue');
  }

  static Future<void> resetStatue() async {
    await _channel.invokeMethod('resetStatue');
  }

  static Future<void> saveData() async {
    await _channel.invokeMethod('saveData');
  }

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: 'unreal_texture_view',
      layoutDirection: TextDirection.ltr,
    );
  }
}
