import 'dart:async';
import 'dart:developer' as developer;

import 'package:async/async.dart';

RestartableTimer createAndStartNonPeriodicRestartableTimer([
  void Function()? callback,
]) => RestartableTimer(const Duration(seconds: 1), () => callback?.call());

void main() {
  final nonPeriodicRestartableTimer = createAndStartNonPeriodicRestartableTimer(
    () {
      developer.log('The given duration has elapsed.');
      developer.log(DateTime.now().toString());
    },
  );

  Future<void>.delayed(
    const Duration(seconds: 3),
    nonPeriodicRestartableTimer.reset,
  );
}
