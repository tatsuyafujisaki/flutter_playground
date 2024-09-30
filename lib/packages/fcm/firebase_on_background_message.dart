import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_playground/firebase_options.dart';
import 'package:flutter_playground/packages/fcm/firebase_message_handler.dart';

/// > There are a few things to keep in mind about your background message handler:
/// > 1. It must not be an anonymous function.
/// > 2. It must be a top-level function (e.g. not a class method which requires initialization).
/// > 3, When using Flutter version 3.3.0 or higher, the message handler must be annotated with @pragma('vm:entry-point') right above the function declaration (otherwise it may be removed during tree shaking for release mode).
/// https://firebase.google.com/docs/cloud-messaging/flutter/receive#apple_platforms_and_android
@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint(
    '🔥FirebaseMessaging.onBackgroundMessage received the following message.',
  );
  printMessage(message);
}

void onBackgroundMessage() {
  // Without this, if you receive a message while the application is closed, no notification will be displayed.
  // https://firebase.google.com/docs/cloud-messaging/flutter/receive#apple_platforms_and_android
  // https://pub.dev/documentation/firebase_messaging/latest/firebase_messaging/FirebaseMessaging/onBackgroundMessage.html
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
}
