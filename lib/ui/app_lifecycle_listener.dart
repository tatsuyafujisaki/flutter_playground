import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';

class MyAppLifecycleChangeNotifier extends ChangeNotifier {
  MyAppLifecycleChangeNotifier() {
    _listener = AppLifecycleListener(
      onStateChange: (state) {
        _state = state;
        developer.log('🔄$state');
      },
    );
  }
  AppLifecycleState _state = AppLifecycleState.resumed;

  AppLifecycleState get state => _state;

  late final AppLifecycleListener _listener;

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }
}
