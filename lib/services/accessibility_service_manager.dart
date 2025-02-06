import 'package:flutter/material.dart';
import 'package:flutter_accessibility_service/flutter_accessibility_service.dart';

class AccessibilityServiceManager extends StatefulWidget {
  @override
  _AccessibilityServiceManagerState createState() => _AccessibilityServiceManagerState();
}

class _AccessibilityServiceManagerState extends State<AccessibilityServiceManager> {
  bool isTrackingEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkAccessibilityPermission();
  }

  Future<void> _checkAccessibilityPermission() async {
    bool isEnabled = await FlutterAccessibilityService.isAccessibilityPermissionEnabled();
    setState(() {
      isTrackingEnabled = isEnabled;
    });
  }

  Future<void> _requestAccessibilityPermission() async {
    await FlutterAccessibilityService.requestAccessibilityPermission();
    _checkAccessibilityPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Monitoraggio Tocchi & Scroll")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Monitoraggio Attivo: ${isTrackingEnabled ? "SI" : "NO"}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isTrackingEnabled ? null : _requestAccessibilityPermission,
              child: Text("Abilita Monitoraggio"),
            ),
          ],
        ),
      ),
    );
  }
}
