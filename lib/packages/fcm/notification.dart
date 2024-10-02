import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

final _notificationPlugin = FlutterLocalNotificationsPlugin();
var _isNotificationPluginInitialized = false;

Future<void> showNotification(RemoteMessage message) async {
  if (message.notification == null) {
    return;
  }

  if (!_isNotificationPluginInitialized) {
    _isNotificationPluginInitialized = true;
    // > The onDidReceiveBackgroundNotificationResponse is currently only for notification actions.
    // > There's no support for dealing with tapping on the notification itself so perhaps this is where your confusion lies
    // https://github.com/MaikuB/flutter_local_notifications/issues/2134#issuecomment-1804800834
    await _notificationPlugin.initialize(
      const InitializationSettings(
        // Specifies the name of a drawable file without the extension in the "android/app/src/main/res/drawable" directory.
        android: AndroidInitializationSettings('android_robot'),
      ),
      onDidReceiveNotificationResponse: (details) {
        debugPrint(
          '🔥onDidReceiveNotificationResponse received the payload: ${details.payload}. In other words, the user tapped a notification while the app was in the foreground.',
        );
      },
    );
  }

  await _notificationPlugin.show(
    message.notification.hashCode,
    message.notification!.title,
    message.notification!.body,
    await _createAndroidNotificationDetails(
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj_Jb2dSHvFPcUjxl753C-AkJDQdD71J9cwskYmrwpw2lcR7CoLEZU77s6ZWcgLsTJ_Rjsn2onNx1TkwlYv2_ziUm49HGN4fsMDccNN2HJBq3Wp-agn5U9Fc45FzDVKDJR81H4HYYF-zhE/s800/animal_inu.png',
    ),
    payload: jsonEncode(message.data),
  );
}

Future<NotificationDetails> _createAndroidNotificationDetails(
  String imageUrl,
) async =>
    NotificationDetails(
      android: AndroidNotificationDetails(
        '',
        'My channel name', // is displayed in Android's notification settings.
        largeIcon: await _createLargeIcon(imageUrl),
      ),
    );

Future<ByteArrayAndroidBitmap> _createLargeIcon(String url) async {
  final response = await http.get(Uri.parse(url));
  return ByteArrayAndroidBitmap(response.bodyBytes);
}
