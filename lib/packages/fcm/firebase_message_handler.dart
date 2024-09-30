import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_playground/packages/fcm/create_android_notification_channel.dart';
import 'package:flutter_playground/packages/fcm/firebase_on_background_message.dart';

class FirebaseMessageHandler {
  FirebaseMessageHandler() {
    onBackgroundMessage();

    Future.delayed(
      Duration.zero,
      () async {
        await _requestPermission;

        final token = await _token;
        if (token != null) {
          _sendTokenToServer(token);
        }

        _onTokenRefreshSubscription = await _listen(
          // https://pub.dev/documentation/firebase_messaging/latest/firebase_messaging/FirebaseMessaging/onTokenRefresh.html
          FirebaseMessaging.instance.onTokenRefresh,
          _sendTokenToServer,
        );

        final initialMessage = await _initialMessage;
        if (initialMessage != null) {
          debugPrint(
            '🔥FirebaseMessaging.instance.getInitialMessage() received the following message.',
          );
          printMessage(initialMessage);
        }

        _onMessageSubscription = await _onMessage;
        _onMessageOpenedAppSubscription = await _onMessageOpenedApp;
      },
    );
  }

  StreamSubscription<String>? _onTokenRefreshSubscription;
  StreamSubscription<RemoteMessage>? _onMessageSubscription;
  StreamSubscription<RemoteMessage>? _onMessageOpenedAppSubscription;

  Future<NotificationSettings?> get _requestPermission async {
    NotificationSettings? settings;
    try {
      // https://firebase.google.com/docs/cloud-messaging/flutter/receive#permissions
      // https://pub.dev/documentation/firebase_messaging/latest/firebase_messaging/FirebaseMessaging/requestPermission.html
      settings = await FirebaseMessaging.instance.requestPermission();
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
    return settings;
  }

  Future<String?> get _token async {
    String? token;
    try {
      // Despite the description below, getToken() does not ask the user for notification permissions.
      // > If notification permission has not been granted, this method will ask the user for notification permissions.
      // https://firebase.google.com/docs/cloud-messaging/flutter/first-message#access_the_registration_token
      //
      // This issue is reported below.
      // https://github.com/firebase/flutterfire/issues/12676
      //
      // https://pub.dev/documentation/firebase_messaging/latest/firebase_messaging/FirebaseMessaging/getToken.html
      token = await FirebaseMessaging.instance.getToken();
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
    return token;
  }

  Future<RemoteMessage?> get _initialMessage async {
    RemoteMessage? message;
    try {
      // > If the application has been opened from a terminated state via a RemoteMessage (containing a Notification), it will be returned, otherwise it will be null.
      // https://pub.dev/documentation/firebase_messaging/latest/firebase_messaging/FirebaseMessaging/getInitialMessage.html
      // https://firebase.google.com/docs/cloud-messaging/flutter/receive#handling_interaction
      message = await FirebaseMessaging.instance.getInitialMessage();
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
    return message;
  }

  /// Recieves messages while the app is in the foreground.
  Future<StreamSubscription<RemoteMessage>?> get _onMessage => _listen(
        // https://firebase.google.com/docs/cloud-messaging/flutter/receive#foreground_messages
        // https://pub.dev/documentation/firebase_messaging/latest/firebase_messaging/FirebaseMessaging/onMessageOpenedApp.html
        FirebaseMessaging.onMessage,
        (message) {
          debugPrint(
            '🔥FirebaseMessaging.onMessage received the following message.',
          );
          printMessage(message);
          showNotification(message);
        },
      );

  /// Recieves a message when the app is in the background.
  Future<StreamSubscription<RemoteMessage>?> get _onMessageOpenedApp => _listen(
        // https://firebase.google.com/docs/cloud-messaging/flutter/receive#handling_interaction
        // https://pub.dev/documentation/firebase_messaging/latest/firebase_messaging/FirebaseMessaging/onMessageOpenedApp.html
        FirebaseMessaging.onMessageOpenedApp,
        (message) {
          debugPrint(
            '🔥FirebaseMessaging.onMessageOpenedApp received the following message.',
          );
          printMessage(message);
        },
      );

  Future<StreamSubscription<T>?> _listen<T>(
    Stream<T> stream,
    void Function(T) onData, {
    Function? onError,
    VoidCallback? onDone,
  }) async {
    StreamSubscription<T>? subscrption;
    try {
      subscrption = stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
      );
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
    return subscrption;
  }

  void _sendTokenToServer(String token) {
    debugPrint(
      '🔥Pretend to send a Firebase Cloud Messaging (FCM) registration token to server: $token',
    );
  }

  // ignore: unreachable_from_main
  Future<void> deleteToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  // ignore: unreachable_from_main
  void dispose() {
    Future.delayed(
      Duration.zero,
      () async {
        await _onTokenRefreshSubscription?.cancel();
        await _onMessageSubscription?.cancel();
        await _onMessageOpenedAppSubscription?.cancel();
      },
    );
  }
}

void printMessage(RemoteMessage message) {
  inspect(message);
  final notification = message.notification;
  if (notification != null) {
    debugPrint('🔥message.notification.title: ${notification.title}');
    debugPrint('🔥message.notification.body: ${notification.body}');
  }
  for (final entry in message.data.entries) {
    debugPrint(
      '🔥message.data.entries (each): ${entry.key}: ${entry.value}',
    );
  }
}
