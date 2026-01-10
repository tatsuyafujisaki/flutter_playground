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
import 'packages/fcm/firebase_message_handler.dart';
import 'packages/fcm/notification.dart';
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
    unawaited(FirebaseCrashlytics.instance.recordFlutterFatalError(details));
  };

  // https://api.flutter.dev/flutter/dart-ui/PlatformDispatcher/onError.html
  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    unawaited(
      FirebaseCrashlytics.instance.recordError(
        exception,
        stackTrace,
        fatal: true,
      ),
    );
    return true;
  };

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp(
    home: UpgradeAlert(
      showIgnore: false,
      showLater: false,
      child: const YoutubePage(),
    ),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}

class _MyStatefulWidget extends StatefulWidget {
  const _MyStatefulWidget({required this.title});
  final String title;

  @override
  State<_MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  final textEditingController = TextEditingController(text: 'My initial text');
  final firebaseMessageHandler = FirebaseMessageHandler();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => enableNotification(context),
    );

    showInternationalizationExamples(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: const SizedBox.expand(child: FlutterLogo()),
    );
  }

  @override
  void dispose() {
    unawaited(firebaseMessageHandler.dispose());
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
