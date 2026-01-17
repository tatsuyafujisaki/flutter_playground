import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

void setupErrorHandling() {
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
