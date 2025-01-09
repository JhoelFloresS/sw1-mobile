import 'dart:ui';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class SettingsLocalNotifications {
  static Future<bool?> requestLocalNotificationPermission() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static Future<void> initializeLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('codex_logo');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  static Future<void> showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? data,
    String? icon,
    String? action,
  }) async {
    final String largeIconPath = await _downloadAndSaveFile(
        icon ?? 'https://dummyimage.com/128x128/00FF00/000000', 'largeIcon');
    final androidDetails = AndroidNotificationDetails(
      'heavyTruckId',
      'heavyTruckChannel',
      playSound: true,
      importance: Importance.max,
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      color: const Color(0x001FA90F),
      priority: Priority.high,
      actions: [
        AndroidNotificationAction(action ?? 'actionId', action ?? 'Ver',
            titleColor: const Color(0x001FA90F)),
      ],
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails,
        payload: data);
  }

  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    print(response);
  }
}
