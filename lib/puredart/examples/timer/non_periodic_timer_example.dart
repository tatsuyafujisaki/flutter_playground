import 'dart:async';

import 'package:flutter/foundation.dart';

Timer _createAndStartNonPeriodicTimer([void Function()? callback]) =>
    Timer(const Duration(seconds: 3), () => callback?.call());

void main() {
  debugPrint('Timer started at ${DateTime.now()}');
  _createAndStartNonPeriodicTimer(
    () => debugPrint('Timer callback is called at ${DateTime.now()}'),
  );
}
