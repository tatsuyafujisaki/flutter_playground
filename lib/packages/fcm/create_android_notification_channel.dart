import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin? notificationsPlugin;
const channel = AndroidNotificationChannel(
  'dummy',
  'dummy',
  importance: Importance.high,
);

/// > Notification messages which arrive while the application is in the foreground will not display a visible notification by default, on both Android and iOS. It is, however, possible to override this behavior:
/// On Android, you must create a "High Priority" notification channel.
/// https://firebase.google.com/docs/cloud-messaging/flutter/receive#foreground_and_notification_messages
Future<void> createAndroidNotificationChannel() async {
  if (notificationsPlugin != null) {
    return;
  }
  try {
    notificationsPlugin = FlutterLocalNotificationsPlugin();
    await notificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
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
    await notificationsPlugin?.show(
      notification.hashCode,
      notification!.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
}
