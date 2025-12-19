import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../../extension/extensions.dart';

final _notificationPlugin = FlutterLocalNotificationsPlugin();

Future<void> enableNotification(BuildContext context) async {
  // > The app must create a channel with this channel ID before any
  //   notification with this channel ID is received.
  // https://firebase.google.com/docs/cloud-messaging/http-server-ref
  Future<AndroidNotificationChannel> createNotificationChannel(
    BuildContext context,
  ) async {
    final channel = AndroidNotificationChannel(
      'my_default_notification_channel_id',
      context.l10n.notificationChannelName,
    );
    await _notificationPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
    return channel;
  }

  Future<void> deleteMiscellaneousNotificationChannel() async =>
      _notificationPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.deleteNotificationChannel('fcm_fallback_notification_channel');

  // > On Android versions 13 and above, there is no way to determine if the user has chosen whether to grant/deny permission.
  // https://firebase.google.com/docs/cloud-messaging/flutter/receive#permissions
  // https://pub.dev/documentation/firebase_messaging/latest/firebase_messaging/FirebaseMessaging/requestPermission.html
  await FirebaseMessaging.instance.requestPermission();

  // > The onDidReceiveBackgroundNotificationResponse is currently only for
  //   notification actions.
  // > There's no support for dealing with tapping on the notification itself
  //   so perhaps this is where your confusion lies
  // https://github.com/MaikuB/flutter_local_notifications/issues/2134#issuecomment-1804800834
  await _notificationPlugin.initialize(
    const InitializationSettings(
      // Specifies the name of a drawable file without the extension in the "android/app/src/main/res/drawable" directory.
      android: AndroidInitializationSettings('android_robot'),
      iOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: (details) {
      debugPrint(
        '''🔥onDidReceiveNotificationResponse received the payload: ${details.payload}. In other words, the user tapped a notification while the app was in the foreground.''',
      );
    },
  );

  await deleteMiscellaneousNotificationChannel();

  if (context.mounted) {
    await createNotificationChannel(context);
  }
}

Future<void> showNotification(RemoteMessage message) async {
  Future<NotificationDetails> createAndroidNotificationDetails(
    String imageUrl,
  ) async {
    Future<ByteArrayAndroidBitmap> createLargeIcon(String url) async {
      final response = await http.get(Uri.parse(url));
      return ByteArrayAndroidBitmap(response.bodyBytes);
    }

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'my_default_notification_channel_id',
        'My Notification Channel',
        largeIcon: await createLargeIcon(imageUrl),
      ),
    );
  }

  if (message.notification == null) {
    return;
  }

  await _notificationPlugin.show(
    message.notification.hashCode,
    message.notification!.title,
    message.notification!.body,
    await createAndroidNotificationDetails(
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj_Jb2dSHvFPcUjxl753C-AkJDQdD71J9cwskYmrwpw2lcR7CoLEZU77s6ZWcgLsTJ_Rjsn2onNx1TkwlYv2_ziUm49HGN4fsMDccNN2HJBq3Wp-agn5U9Fc45FzDVKDJR81H4HYYF-zhE/s800/animal_inu.png',
    ),
    payload: jsonEncode(message.data),
  );
}
