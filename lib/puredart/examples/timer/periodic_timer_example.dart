import 'dart:async';

import 'package:flutter/foundation.dart';

class PeriodicRestartableTimer {
  PeriodicRestartableTimer(this.duration, this.callback) {
    _timer = _createTimer();
  }

  Duration duration;
  void Function()? callback;

  void restart() {
    _timer?.cancel();
    _timer = _createTimer();
  }

  void cancel() => _timer?.cancel();

  Timer _createTimer() => Timer.periodic(duration, (_) => callback?.call());

  Timer? _timer;
}

void main() {
  final timer = PeriodicRestartableTimer(
    const Duration(seconds: 1),
    () => debugPrint(DateTime.now().toString()),
  );

  Future<void>.delayed(const Duration(seconds: 3), timer.restart);

  Future<void>.delayed(const Duration(seconds: 6), timer.cancel);
}
