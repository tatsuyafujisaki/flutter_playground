import 'dart:developer' as developer;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgrader/upgrader.dart';

import 'l10n/app_localizations.dart';
import 'ui/page/google_maps_page.dart';
import 'ui/provider/my_app_lifecycle_state.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final lifecycleState = ref.watch(myAppLifecycleStateProvider);
    developer.log('🔄${lifecycleState.name}');

    return MaterialApp(
      home: Stack(
        children: [
          UpgradeAlert(
            showIgnore: false,
            showLater: false,
            child: const GoogleMapsPage(),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: lifecycleState == AppLifecycleState.paused
                  ? Colors.orange
                  : Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Text(
                'App State: ${lifecycleState.name}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
