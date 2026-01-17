import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_app_lifecycle_provider.g.dart';

@Riverpod(keepAlive: true)
class AppLifecycle extends _$AppLifecycle {
  @override
  AppLifecycleState build() {
    final listener = AppLifecycleListener(
      onStateChange: (state) {
        developer.log('🔄$state');
        this.state = state;
      },
    );
    ref.onDispose(listener.dispose);
    return WidgetsBinding.instance.lifecycleState ?? AppLifecycleState.resumed;
  }
}
