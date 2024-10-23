import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class PermissionHandler {
  static Future<void> requestExactAlarmPermission() async {
    // Verifica se stai eseguendo il codice su Android e se la versione è Android 12 o superiore
    if (Platform.isAndroid && (await _getAndroidSdkVersion() ?? 0) >= 31) {
      try {
        // Chiama il metodo per richiedere il permesso di allarmi esatti
        final MethodChannel channel = MethodChannel('exact_alarm_permission');
        await channel.invokeMethod('requestExactAlarmPermission');
      } catch (e) {
        Get.snackbar('Error', 'Failed to request exact alarm permission: $e');
      }
    }
  }

  static Future<int?> _getAndroidSdkVersion() async {
    try {
      final version = await MethodChannel('get_sdk_version').invokeMethod<int>('getSdkVersion');
      return version;
    } catch (e) {
      print("Failed to get Android SDK version: $e");
      return null;
    }
  }
}
