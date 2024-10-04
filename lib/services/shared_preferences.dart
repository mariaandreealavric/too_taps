import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static const String startTimeKey = 'startTime';

  Future<void> saveStartTime(DateTime startTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(startTimeKey, startTime.toIso8601String());
  }

  Future<DateTime?> getStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? startTimeString = prefs.getString(startTimeKey);
    return startTimeString != null ? DateTime.parse(startTimeString) : null;
  }

  Future<void> removeStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(startTimeKey);
  }
}
