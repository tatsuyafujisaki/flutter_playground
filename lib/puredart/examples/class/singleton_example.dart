/// https://stackoverflow.com/a/12649574/10867055
class _MySingleton {
  factory _MySingleton() {
    if (!initialized) {
      initialized = true;
      print('Perform some initialization.');
    }
    return _singleton;
  }
  _MySingleton._();
  static final _singleton = _MySingleton._();
  static bool initialized = false;
  final initializedAt = DateTime.now();
}

void main() {
  print(_MySingleton() == _MySingleton()); // true
  print(_MySingleton().initializedAt); // prints the same timestamp as above.
}
