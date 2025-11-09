import 'dart:async';

import 'package:async/async.dart';

RestartableTimer createAndStartNonPeriodicRestartableTimer([
  void Function()? callback,
]) => RestartableTimer(const Duration(seconds: 1), () => callback?.call());

void main() {
  final nonPeriodicRestartableTimer = createAndStartNonPeriodicRestartableTimer(
    () {
      print('The given duration has elapsed.');
      print(DateTime.now());
    },
  );

  Future<void>.delayed(
    const Duration(seconds: 3),
    nonPeriodicRestartableTimer.reset,
  );
}
