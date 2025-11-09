import 'dart:async';

void main() async {
  final streamController =
      StreamController<String>.broadcast()
        ..stream.listen((event) => print('Listener 1: $event'))
        ..stream.listen((event) => print('Listener 2: $event'))
        ..add('🍎')
        ..add('🍊');

  await streamController.close();
}
