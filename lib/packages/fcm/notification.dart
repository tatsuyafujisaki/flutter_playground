import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_playground/packages/flutter_local_example.dart';

FlutterLocalNotificationsPlugin? _notificationsPlugin;
const _channel = AndroidNotificationChannel(
  'dummy',
  'dummy',
  importance: Importance.high,
);

/// > Notification messages which arrive while the application is in the foreground will not display a visible notification by default, on both Android and iOS. It is, however, possible to override this behavior:
/// On Android, you must create a "High Priority" notification channel.
/// https://firebase.google.com/docs/cloud-messaging/flutter/receive#foreground_and_notification_messages
Future<void> createAndroidNotificationChannel() async {
  if (_notificationsPlugin != null) {
    return;
  }
  try {
    _notificationsPlugin = FlutterLocalNotificationsPlugin();
    await _notificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
}

Future<void> showNotification(RemoteMessage message) async {
  final notification = message.notification;
  if (notification?.android == null) {
    return;
  }
  try {
    await _notificationsPlugin?.show(
      notification.hashCode,
      notification!.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          icon: 'android_robot',
          largeIcon: await createLargeIcon(
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj_Jb2dSHvFPcUjxl753C-AkJDQdD71J9cwskYmrwpw2lcR7CoLEZU77s6ZWcgLsTJ_Rjsn2onNx1TkwlYv2_ziUm49HGN4fsMDccNN2HJBq3Wp-agn5U9Fc45FzDVKDJR81H4HYYF-zhE/s800/animal_inu.png',
          ),
        ),
      ),
    );
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
}
