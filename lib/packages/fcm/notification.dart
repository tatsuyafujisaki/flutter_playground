import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
var _isPluginInitialized = false;

Future<void> showNotification(RemoteMessage message) async {
  final notification = message.notification;
  if (notification == null) {
    return;
  }

  if (!_isPluginInitialized) {
    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('android_robot'),
      ),
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveBackgroundNotificationResponse,
    );
    _isPluginInitialized = true;
  }

  await _plugin.show(
    notification.hashCode,
    notification.title,
    notification.body,
    await _createAndroidNotificationDetails(
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj_Jb2dSHvFPcUjxl753C-AkJDQdD71J9cwskYmrwpw2lcR7CoLEZU77s6ZWcgLsTJ_Rjsn2onNx1TkwlYv2_ziUm49HGN4fsMDccNN2HJBq3Wp-agn5U9Fc45FzDVKDJR81H4HYYF-zhE/s800/animal_inu.png',
    ),
  );
}

void _onDidReceiveNotificationResponse(NotificationResponse response) {
  debugPrint(
    '👀onDidReceiveNotificationResponse received the following response.',
  );
  inspect(response);
}

void _onDidReceiveBackgroundNotificationResponse(
  NotificationResponse response,
) {
  debugPrint(
    '👀onDidReceiveBackgroundNotificationResponse received the following response.',
  );
  inspect(response);
}

Future<NotificationDetails> _createAndroidNotificationDetails(
  String imageUrl,
) async =>
    NotificationDetails(
      android: AndroidNotificationDetails(
        'My channel id',
        'My channel name',
        largeIcon: await _createLargeIcon(imageUrl),
      ),
    );

Future<ByteArrayAndroidBitmap> _createLargeIcon(String url) async {
  final response = await http.get(Uri.parse(url));
  return ByteArrayAndroidBitmap(response.bodyBytes);
}
