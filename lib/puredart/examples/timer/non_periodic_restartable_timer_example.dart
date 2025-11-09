import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';

RestartableTimer createAndStartNonPeriodicRestartableTimer([
  void Function()? callback,
]) => RestartableTimer(const Duration(seconds: 1), () => callback?.call());

void main() {
  final nonPeriodicRestartableTimer = createAndStartNonPeriodicRestartableTimer(
    () {
      debugPrint('The given duration has elapsed.');
      debugPrint(DateTime.now().toString());
    },
  );

  Future<void>.delayed(
    const Duration(seconds: 3),
    nonPeriodicRestartableTimer.reset,
  );
}
