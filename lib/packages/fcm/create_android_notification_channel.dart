import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

bool _isChannelCreated = false;

/// > Notification messages which arrive while the application is in the foreground will not display a visible notification by default, on both Android and iOS. It is, however, possible to override this behavior:
/// On Android, you must create a "High Priority" notification channel.
/// https://firebase.google.com/docs/cloud-messaging/flutter/receive#foreground_and_notification_messages
Future<void> createAndroidNotificationChannel() async {
  if (_isChannelCreated) {
    return;
  }
  try {
    const channel = AndroidNotificationChannel(
      'My id',
      'My name',
      importance: Importance.high,
    );
    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
  _isChannelCreated = true;
}
