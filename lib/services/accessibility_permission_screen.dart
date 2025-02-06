import 'package:flutter/material.dart';
import 'package:flutter_accessibility_service/flutter_accessibility_service.dart';

class AccessibilityPermissionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attiva il Servizio di Accessibilità")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Questa app utilizza il servizio di accessibilità per creare un'esperienza artistica interattiva. "
                  "Ogni tocco e scroll frantuma digitalmente un'opera d'arte, aumentandone la consapevolezza.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FlutterAccessibilityService.requestAccessibilityPermission();
              },
              child: Text("Attiva il Servizio"),
            ),
          ],
        ),
      ),
    );
  }
}
