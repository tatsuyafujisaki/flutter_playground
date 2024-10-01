import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

final _notificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> showNotification(RemoteMessage message) async {
  final notification = message.notification;
  if (notification == null) {
    return;
  }
  try {
    await _notificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      await _createAndroidNotificationDetails(
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj_Jb2dSHvFPcUjxl753C-AkJDQdD71J9cwskYmrwpw2lcR7CoLEZU77s6ZWcgLsTJ_Rjsn2onNx1TkwlYv2_ziUm49HGN4fsMDccNN2HJBq3Wp-agn5U9Fc45FzDVKDJR81H4HYYF-zhE/s800/animal_inu.png',
      ),
    );
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
}

Future<NotificationDetails> _createAndroidNotificationDetails(
  String imageUrl,
) async =>
    NotificationDetails(
      android: AndroidNotificationDetails(
        'My channel id',
        'My channel name',
        icon: 'android_robot',
        largeIcon: await _createLargeIcon(imageUrl),
      ),
    );

Future<ByteArrayAndroidBitmap> _createLargeIcon(String url) async {
  final response = await http.get(Uri.parse(url));
  return ByteArrayAndroidBitmap(response.bodyBytes);
}
