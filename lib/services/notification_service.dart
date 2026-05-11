
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin notifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotification() async {
    const AndroidInitializationSettings android =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await notifications.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    if (Platform.isAndroid) {
      notifications
          .resolvePlatformSpecificImplementation;
      AndroidFlutterLocalNotificationsPlugin()
          .requestNotificationsPermission();

      notifications
          .resolvePlatformSpecificImplementation;
      AndroidFlutterLocalNotificationsPlugin()
          .requestExactAlarmsPermission();
    } else {
      notifications
          .resolvePlatformSpecificImplementation;
      IOSFlutterLocalNotificationsPlugin()
          .requestPermissions();
    }

    tz.initializeTimeZones();
    debugPrint(' Notifications initialized');
  }


  static Future<void> scheduleEvery2Minutes() async {
    await notifications.cancelAll();
    debugPrint('🗑 All old notifications cancelled');

    const List<String> messages = [
      'Aaj ka kharch add kiya? ',
      'Budget track karo! ',
      'Expense mat bhoolo! ',
      'Aaj kitna kharch hua? ',
      'Daily expense update karo! ',
    ];


    for (int i = 0; i < 30; i++) {
      final scheduledTime =
      tz.TZDateTime.now(tz.local).add(Duration(minutes: 2 * (i + 1)));

      await notifications.zonedSchedule(
        i,
        'Expense Tracker',
        messages[i % messages.length],
        scheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'expense_tracker_app',
            'Reminders',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );

      debugPrint(' Notification $i scheduled at: $scheduledTime');
    }

    debugPrint('30 notifications scheduled — har 2 min pe aayegi!');
  }


  static Future<void> scheduleDailyAt({
    int id = 101,
    String title = 'Expense Reminder',
    String body = "Aaj ka kharch add kiya? ",
    int hour = 21,
    int minute = 0,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await notifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminders',
          'Daily Expense Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    debugPrint('Daily reminder set: roz $hour:$minute baje');
  }

  static Future<void> cancelAll() async {
    await notifications.cancelAll();
    debugPrint('All notifications cancelled');
  }
}


