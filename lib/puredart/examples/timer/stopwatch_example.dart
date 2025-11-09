import 'dart:async';

import 'package:flutter/foundation.dart';

void main() {
  final stopwatch = Stopwatch();
  debugPrint(stopwatch.elapsed.toString()); // 0
  debugPrint(stopwatch.isRunning.toString()); // false
  stopwatch.start();
  debugPrint(stopwatch.isRunning.toString()); // true
  Future<void>.delayed(const Duration(seconds: 3), () {
    stopwatch.stop();
    debugPrint(stopwatch.elapsed.toString()); // 3 seconds
    debugPrint(stopwatch.isRunning.toString()); // false
  });
}
