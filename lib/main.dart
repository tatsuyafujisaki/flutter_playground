import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_playground/extension/extensions.dart';
import 'package:flutter_playground/firebase_options.dart';
import 'package:flutter_playground/packages/firebase_message_handler.dart';
import 'package:flutter_playground/shared_preferences/encypted_shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
    return true;
  };
  await EncryptedSharedPreferences.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('👀Platform version: ${Platform.version}');

    return MaterialApp(
      home: const _MyStatefulWidget(title: 'Flutter Demo Home Page'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

class _MyStatefulWidget extends StatefulWidget {
  const _MyStatefulWidget({required this.title});
  final String title;

  @override
  State<_MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  final myTextEditingController = TextEditingController(text: 'Initial text!');
  int counter = 0;
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
        // Here we take the value from the MyHomePage object that was created
        // by the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command
          // in Visual Studio Code) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is
          // the vertical axis because Columns are vertical
          // (the cross axis would be horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(context.l10n.pushButtonCountLabel),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    firebaseMessageHandler.dispose();
    myTextEditingController.dispose();
    super.dispose();
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }
}
