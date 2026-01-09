import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static const int _reportNotificationId = 21;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _timezoneInitialized = false;
  void Function(String?)? _onNotificationTap;

  Future<void> initialize({required void Function(String?) onNotificationTap}) async {
    _onNotificationTap = onNotificationTap;
    _ensureTimezoneInitialized();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        _onNotificationTap?.call(details.payload);
      },
    );
  }

  Future<bool> requestPermissions() async {
    final androidImplementation =
        _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();
    final iosImplementation = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    final bool androidGranted = await androidImplementation
            ?.requestNotificationsPermission() ??
        true;
    final bool iosGranted = await iosImplementation?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        ) ??
        true;

    return androidGranted && iosGranted;
  }

  Future<void> scheduleDailyReportNotification() async {
    _ensureTimezoneInitialized();
    const Time time = Time(21, 30, 0);

    const androidDetails = AndroidNotificationDetails(
      'daily_notification_channel_id',
      'Promemoria quotidiani',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      _reportNotificationId,
      'TOO-Taps',
      'Apri il tuo Report',
      _nextInstanceOfTime(time),
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '/pod',
    );
  }

  Future<void> cancelReportNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(_reportNotificationId);
  }

  Future<void> showNotification(int id, String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'Notifiche generiche',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(Time time) {
    _ensureTimezoneInitialized();
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _ensureTimezoneInitialized() async {
    if (_timezoneInitialized) {
      return;
    }
    tzdata.initializeTimeZones();
    final String timezoneName =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneName));
    _timezoneInitialized = true;
  }
}

class Time {
  final int hour;
  final int minute;
  final int second;

  const Time(this.hour, this.minute, this.second);
}
