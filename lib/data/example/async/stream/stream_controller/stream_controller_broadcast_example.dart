import 'dart:async';
import 'dart:developer' as developer;

void main() async {
  final streamController = StreamController<String>.broadcast()
    ..stream.listen((event) => developer.log('Listener 1: $event'))
    ..stream.listen((event) => developer.log('Listener 2: $event'))
    ..add('🍎')
    ..add('🍊');

  await streamController.close();
}
