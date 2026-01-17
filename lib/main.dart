import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  _setupErrorHandling();

  runApp(const ProviderScope(child: MyApp()));
}

void _setupErrorHandling() {
  FlutterError.onError = (details) {
    if (kDebugMode) {
      FlutterError.presentError(details);
    } else {
      unawaited(FirebaseCrashlytics.instance.recordFlutterFatalError(details));
    }
  };

  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    if (!kDebugMode) {
      unawaited(
        FirebaseCrashlytics.instance.recordError(
          exception,
          stackTrace,
          fatal: true,
        ),
      );
    }
    return !kDebugMode;
  };
}
