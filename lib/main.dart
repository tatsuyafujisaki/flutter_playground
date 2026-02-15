import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'firebase_options_dev.dart' as dev;
import 'firebase_options_prod.dart' as prod;
import 'ui/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureFlavor();
  _setupErrorHandling();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _configureFlavor() async {
  final packageInfo = await PackageInfo.fromPlatform();
  await Firebase.initializeApp(
    options: packageInfo.packageName.endsWith('dev')
        ? dev.DefaultFirebaseOptions.currentPlatform
        : prod.DefaultFirebaseOptions.currentPlatform,
  );
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
