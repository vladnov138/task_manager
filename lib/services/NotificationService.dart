import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings('@drawable/launch_background');

  Future<void> initilizeNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> sendNotification(
      int notificationId, String title, String body, DateTime dateTime) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max, priority: Priority.high);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    debugPrint("Registration: ");
    debugPrint(dateTime.toString());
    await _flutterLocalNotificationsPlugin.zonedSchedule(notificationId, title,
        body, tz.TZDateTime.from(dateTime, tz.UTC), notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotification(int notificationId) async {
    await _flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<void> updateNotification(
      int notificationId, String title, String body, DateTime dateTime) async {
      cancelNotification(notificationId);
      sendNotification(notificationId, title, body, dateTime);
  }
}
