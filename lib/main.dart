import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/error_handling.dart';
import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  developer.log(
    '👀GOOGLE_MAPS_PLATFORM_API_KEY: '
    '${const String.fromEnvironment('GOOGLE_MAPS_PLATFORM_API_KEY')}',
  );
  developer.log(
    '👀YOUTUBE_API_KEY: ${const String.fromEnvironment('YOUTUBE_API_KEY')}',
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupErrorHandling();

  runApp(const ProviderScope(child: MyApp()));
}
