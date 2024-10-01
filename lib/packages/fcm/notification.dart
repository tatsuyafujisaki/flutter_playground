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
    _isPluginInitialized = true;
    // > The onDidReceiveBackgroundNotificationResponse is currently only for notification actions.
    // > There's no support for dealing with tapping on the notification itself so perhaps this is where your confusion lies
    // https://github.com/MaikuB/flutter_local_notifications/issues/2134#issuecomment-1804800834
    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('android_robot'),
      ),
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  await _plugin.show(
    notification.hashCode,
    notification.title,
    notification.body,
    await _createAndroidNotificationDetails(
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj_Jb2dSHvFPcUjxl753C-AkJDQdD71J9cwskYmrwpw2lcR7CoLEZU77s6ZWcgLsTJ_Rjsn2onNx1TkwlYv2_ziUm49HGN4fsMDccNN2HJBq3Wp-agn5U9Fc45FzDVKDJR81H4HYYF-zhE/s800/animal_inu.png',
    ),
    payload: '🍎',
  );
}

void _onDidReceiveNotificationResponse(NotificationResponse response) {
  debugPrint('NotificationResponse.payload: ${response.payload}');
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
