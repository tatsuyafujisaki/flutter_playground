import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_playground/extension/extensions.dart';
import 'package:flutter_playground/firebase_options.dart';
import 'package:flutter_playground/packages/fcm/firebase_message_handler.dart';
import 'package:flutter_playground/shared_preferences/encypted_shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  debugPrint('👀Platform version: ${Platform.version}');
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
    return true;
  };
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EncryptedSharedPreferences.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp(
        home: const _MyStatefulWidget(title: 'My title'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
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
  void initState() {
    super.initState();
    debugPrint('👀initState() is called!');
  }

  @override
  Widget build(BuildContext context) {
    // In the English locale, this will print "Jane Doe".
    // In the Japanese locale, this will print "Doe Jane".
    debugPrint('👀Full name: ${context.l10n.fullName('Jane', 'Doe')}');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    firebaseMessageHandler.dispose();
    textEditingController.dispose();
    super.dispose();
  }
}
