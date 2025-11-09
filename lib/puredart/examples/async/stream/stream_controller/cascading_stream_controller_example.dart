import 'dart:async';

// This example is ...
//   - impractical and not worth reading for many people.
//   - for me to get used to some legacy code.
class _MyParentClass {
  final streamController = StreamController<String>.broadcast();

  void parentNotify() {
    streamController.add('parentNotify is called.');
  }
}

class _MyChildClass extends _MyParentClass {
  void childNotify() {
    streamController.add('childNotify is called.');
  }
}

void main() async {
  final myChildClass = _MyChildClass();

  myChildClass.streamController.stream.listen(
    (event) => print('onData: $event'),
  );

  myChildClass
    ..parentNotify()
    ..childNotify();
}
