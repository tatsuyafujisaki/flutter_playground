import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

final _notificationPlugin = FlutterLocalNotificationsPlugin();
const _channel = AndroidNotificationChannel(
  'my_notification_channel',
  'My Notification', // is displayed in Android's notification settings.
);

Future<void> initializeNotificationPlugin() async {
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
  await _createNotificationChannel();
}

// > The app must create a channel with this channel ID before any notification with this channel ID is received.
// https://firebase.google.com/docs/cloud-messaging/http-server-ref
Future<void> _createNotificationChannel() async {
  await _notificationPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_channel);
}

Future<void> showNotification(RemoteMessage message) async {
  if (message.notification == null) {
    return;
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
        _channel.id,
        _channel.name,
        largeIcon: await _createLargeIcon(imageUrl),
      ),
    );

Future<ByteArrayAndroidBitmap> _createLargeIcon(String url) async {
  final response = await http.get(Uri.parse(url));
  return ByteArrayAndroidBitmap(response.bodyBytes);
}
