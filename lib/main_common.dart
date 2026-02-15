import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/utils/coffee_log_utils.dart';
import 'my_app.dart';
import 'others/error_handling.dart';

Future<void> mainCommon(FirebaseOptions firebaseOptions) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: firebaseOptions);

  setupErrorHandling();

  final container = ProviderContainer();
  unawaited(logNearbyCoffeeChains(container));

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}
