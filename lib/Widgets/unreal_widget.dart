import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnrealWidget extends StatelessWidget {
  const UnrealWidget({super.key});

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

  static Future<void> sendTapEvent({required int taps, Offset? position}) async {
    final payload = <String, dynamic>{
      'event': 'tap',
      'taps': taps,
    };

    if (position != null) {
      payload['x'] = position.dx;
      payload['y'] = position.dy;
    }

    await _channel.invokeMethod('handleTap', payload);
  }

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const AndroidView(
          viewType: 'unreal_texture_view',
          layoutDirection: TextDirection.ltr,
        );
      case TargetPlatform.iOS:
        return const UiKitView(
          viewType: 'unreal_texture_view',
          layoutDirection: TextDirection.ltr,
        );
      default:
        return const Center(
          child: Text('Piattaforma non supportata per UnrealView'),
        );
    }
  }
}
