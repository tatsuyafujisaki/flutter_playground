import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgrader/upgrader.dart';

import 'firebase_options.dart';
import 'google_maps_page.dart';
import 'l10n/app_localizations.dart';
import 'packages/analytics/my_analytics_provider.dart';
import 'packages/analytics/my_analytics_service.dart';
import 'ui/app_lifecycle_listener.dart';
import 'ui/my_app_lifecycle_provider.dart';

void main() async {
  // https://api.flutter.dev/flutter/widgets/WidgetsFlutterBinding/ensureInitialized.html
  WidgetsFlutterBinding.ensureInitialized();

  // https://pub.dev/documentation/firebase_core/latest/firebase_core/Firebase/initializeApp.html
  // https://firebase.google.com/docs/flutter/setup?platform=ios#initialize-firebase
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // https://api.flutter.dev/flutter/foundation/FlutterError/onError.html
  FlutterError.onError = (details) {
    if (kDebugMode) {
      // In debug mode, show the error in the console/red screen.
      FlutterError.presentError(details);
    } else {
      // In release mode, send to Crashlytics.
      unawaited(FirebaseCrashlytics.instance.recordFlutterFatalError(details));
    }
  };

  // https://api.flutter.dev/flutter/dart-ui/PlatformDispatcher/onError.html
  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    // In release mode, send to Crashlytics.
    if (!kDebugMode) {
      unawaited(
        FirebaseCrashlytics.instance.recordError(
          exception,
          stackTrace,
          fatal: true,
        ),
      );
    }
    // In debug mode, return false to let Flutter show the error in the console
    // and red screen. In release mode, return true to suppress the error
    // after sending it to Crashlytics.
    return !kDebugMode;
  };

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final analyticsService = ref.watch(analyticsServiceProvider);
    final lifecycleProvider = ref.watch(appLifecycleProvider);

    // Handle lifecycle state changes
    ref.listen<MyAppLifecycleChangeNotifier>(appLifecycleProvider, (
      previous,
      next,
    ) {
      if (previous?.state != next.state) {
        switch (next.state) {
          case AppLifecycleState.resumed:
            // App came back to foreground - could refresh data,
            // restart services
            _handleAppResumed(analyticsService);
          case AppLifecycleState.paused:
            // App went to background - could pause expensive operations
            _handleAppPaused(analyticsService);
          case AppLifecycleState.inactive:
            // App is inactive (e.g., during phone call)
            _handleAppInactive(analyticsService);
          case AppLifecycleState.detached:
            // App is about to be terminated
            _handleAppDetached(analyticsService);
          case AppLifecycleState.hidden:
            // App is hidden (new in Flutter 3.13)
            _handleAppHidden(analyticsService);
        }
      }
    });

    return MaterialApp(
      home: Stack(
        children: [
          UpgradeAlert(
            showIgnore: false,
            showLater: false,
            child: const GoogleMapsPage(),
          ),
          // App lifecycle indicator
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: lifecycleProvider.state == AppLifecycleState.paused
                  ? Colors.orange
                  : Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Text(
                'App State: ${lifecycleProvider.state.name}',
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorObservers: [
        _AnalyticsNavigatorObserver(analyticsService: analyticsService),
      ],
    );
  }

  void _handleAppResumed(MyAnalyticsService analyticsService) {
    // Log analytics event when app resumes
    unawaited(analyticsService.logEvent(name: 'app_resumed'));
  }

  void _handleAppPaused(MyAnalyticsService analyticsService) {
    // Log analytics event when app pauses
    unawaited(analyticsService.logEvent(name: 'app_paused'));
  }

  void _handleAppInactive(MyAnalyticsService analyticsService) {
    // Log analytics event when app becomes inactive
    unawaited(analyticsService.logEvent(name: 'app_inactive'));
  }

  void _handleAppDetached(MyAnalyticsService analyticsService) {
    // Log analytics event when app is detached
    unawaited(analyticsService.logEvent(name: 'app_detached'));
  }

  void _handleAppHidden(MyAnalyticsService analyticsService) {
    // Log analytics event when app is hidden
    unawaited(analyticsService.logEvent(name: 'app_hidden'));
  }
}

class _AnalyticsNavigatorObserver extends NavigatorObserver {
  _AnalyticsNavigatorObserver({required this.analyticsService});

  final MyAnalyticsService analyticsService;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logScreenView(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _logScreenView(newRoute);
    }
  }

  void _logScreenView(Route<dynamic> route) {
    final settings = route.settings;
    if (settings.name != null) {
      unawaited(
        analyticsService.logScreenView(
          screenName: settings.name!,
          screenClass: settings.name,
        ),
      );
    }
  }
}
