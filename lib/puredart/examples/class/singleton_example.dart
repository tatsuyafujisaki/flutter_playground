import 'dart:developer' as developer;

/// https://stackoverflow.com/a/12649574/10867055
class _MySingleton {
  factory _MySingleton() {
    if (!initialized) {
      initialized = true;
      developer.log('Perform some initialization.');
    }
    return _singleton;
  }
  _MySingleton._();
  static final _singleton = _MySingleton._();
  static bool initialized = false;
  final initializedAt = DateTime.now();
}

void main() {
  developer.log((_MySingleton() == _MySingleton()).toString()); // true
  developer.log(
    _MySingleton().initializedAt.toString(),
  ); // prints the same timestamp as above.
}
