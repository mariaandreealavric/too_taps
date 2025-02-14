import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_taps/controllers/theme_controller.dart';
import 'package:too_taps/controllers/Contatori/touch_counter.dart';
import 'package:too_taps/controllers/Contatori/scroll_counter.dart';
import 'package:too_taps/controllers/user_controller.dart';
import 'package:too_taps/controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final touchCounter = Get.find<TouchCounter>();
    final scrollCounter = Get.find<ScrollCounter>();
    final settingsController = Get.find<SettingsController>();
    final profileController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.edit),
              onTap: () {
                Get.toNamed('/profilo');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: settingsController.notificationsEnabled.value,
              onChanged: (value) {
                settingsController.toggleNotifications();
              },
            ),
            const Divider(),
             ListTile(
              leading: Icon(Icons.language),
              title: Text('Language', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            DropdownButton<String>(
              value: settingsController.selectedLanguage.value,
              items: settingsController.languages
                  .map((lang) => DropdownMenuItem(
                value: lang,
                child: Text(lang),
              ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  settingsController.changeLanguage(value);
                }
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
