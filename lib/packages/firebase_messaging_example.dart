import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseMessagingController {
  Future<String?> get token async {
    String? token;
    try {
      token = await FirebaseMessaging.instance.getToken();
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
    return token;
  }

  Future<RemoteMessage?> get initialMessage async {
    RemoteMessage? message;
    try {
      message = await FirebaseMessaging.instance.getInitialMessage();
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
    return message;
  }

  Future<NotificationSettings?> get requestPermission async {
    NotificationSettings? settings;
    try {
      settings = await FirebaseMessaging.instance.requestPermission();
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
    return settings;
  }

  Future<StreamSubscription<RemoteMessage>?> onMessage(
    void Function(RemoteMessage) onData,
    Function? onError,
    VoidCallback? onDone,
  ) async =>
      _listen(
        FirebaseMessaging.onMessage,
        onData,
        onError: onError,
        onDone: onDone,
      );

  Future<StreamSubscription<RemoteMessage>?> onMessageOpenedApp(
    Stream<RemoteMessage> stream,
    void Function(RemoteMessage) onData,
    Function? onError,
    VoidCallback? onDone,
  ) async =>
      _listen(
        FirebaseMessaging.onMessageOpenedApp,
        onData,
        onError: onError,
        onDone: onDone,
      );

  void onBackgroundMessage(BackgroundMessageHandler handler) {
    try {
      FirebaseMessaging.onBackgroundMessage(handler);
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  Future<StreamSubscription<RemoteMessage>?> _listen(
    Stream<RemoteMessage> stream,
    void Function(RemoteMessage) onData, {
    Function? onError,
    VoidCallback? onDone,
  }) async {
    StreamSubscription<RemoteMessage>? subscrption;
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

  Future<void> deleteToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }
}
