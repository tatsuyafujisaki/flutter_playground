import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_playground/extension/extensions.dart';
import 'package:flutter_playground/firebase_options.dart';
import 'package:flutter_playground/packages/fcm/firebase_message_handler.dart';
import 'package:flutter_playground/packages/fcm/notification.dart';
import 'package:flutter_playground/shared_preferences/encypted_shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  debugPrint('Platform version: ${Platform.version}');

  // https://api.flutter.dev/flutter/widgets/WidgetsFlutterBinding/ensureInitialized.html
  WidgetsFlutterBinding.ensureInitialized();

  // https://pub.dev/documentation/firebase_core/latest/firebase_core/Firebase/initializeApp.html
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Records uncaught errors caused by my Dart code as fatal in Firebase
  // Crashlytics.
  // https://api.flutter.dev/flutter/foundation/FlutterError/onError.html
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    // Records uncaught platform-level errors as fatal in Firebase Crashlytics.
    // https://api.flutter.dev/flutter/dart-ui/PlatformDispatcher/onError.html
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    return true;
  };

  await EncryptedSharedPreferences().initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const MaterialApp(
    home: _MyStatefulWidget(title: 'My title'),
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
    // In the English locale, this will print "John Doe".
    // In the Japanese locale, this will print "Doe John".
    debugPrint('''Full name: ${context.l10n.fullName('John', 'Doe')}''');

    debugPrint(context.l10n.piDouble(3.14));
    debugPrint(context.l10n.piNum(3.14));
  }
}
