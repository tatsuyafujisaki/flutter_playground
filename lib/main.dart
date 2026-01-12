import 'dart:async';
import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgrader/upgrader.dart';

import 'extension/extensions.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'packages/analytics/my_analytics_provider.dart';
import 'packages/analytics/my_analytics_service.dart';
import 'youtube/youtube_page.dart';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => unawaited(ref.read(analyticsServiceProvider).logAppOpen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final analyticsService = ref.watch(analyticsServiceProvider);

    return MaterialApp(
      home: UpgradeAlert(
        showIgnore: false,
        showLater: false,
        child: const YoutubePage(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorObservers: [
        _AnalyticsNavigatorObserver(analyticsService: analyticsService),
      ],
    );
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

class _MyStatefulWidget extends StatefulWidget {
  const _MyStatefulWidget({required this.title});
  final String title;

  @override
  State<_MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  final TextEditingController textEditingController = TextEditingController(
    text: 'My initial text',
  );

  @override
  Widget build(BuildContext context) {
    showInternationalizationExamples(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: const SizedBox.expand(child: FlutterLogo()),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void showInternationalizationExamples(BuildContext context) {
    // This is an example of changing the order of first name and last name
    // depending on the locale.
    //
    // In the English locale, this will log "John Doe".
    // In the Japanese locale, this will log "Doe John".
    developer.log('''Full name: ${context.l10n.fullName('John', 'Doe')}''');

    developer.log(context.l10n.piDouble(3.14));
    developer.log(context.l10n.piNum(3.14));
  }
}
