import 'package:flutter/foundation.dart';

/// https://stackoverflow.com/a/12649574/10867055
class _MySingleton {
  factory _MySingleton() {
    if (!initialized) {
      initialized = true;
      debugPrint('Perform some initialization.');
    }
    return _singleton;
  }
  _MySingleton._();
  static final _singleton = _MySingleton._();
  static bool initialized = false;
  final initializedAt = DateTime.now();
}

void main() {
  debugPrint((_MySingleton() == _MySingleton()).toString()); // true
  debugPrint(
    _MySingleton().initializedAt.toString(),
  ); // prints the same timestamp as above.
}
