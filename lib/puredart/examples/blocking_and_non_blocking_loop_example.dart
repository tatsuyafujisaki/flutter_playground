import 'dart:async';

void main() async {
  await _showBlockingLoopExample1();
  await _showBlockingLoopExample2();
  await _showNonBlockingLoopExample1();
  await _showNonBlockingLoopExample2();
}

Stream<int> get _stream =>
    Stream<int>.periodic(const Duration(seconds: 1), (count) => count).take(3);

Future<void> _showNonBlockingLoopExample1() async {
  Timer.periodic(const Duration(seconds: 1), (timer) {
    print('Timer.tick: ${timer.tick}');
    if (timer.tick == 3) {
      timer.cancel();
    }
  });
}

Future<void> _showNonBlockingLoopExample2() async {
  _stream.listen((value) {
    print('Stream.value in a non-blocking loop: $value');
  });
}

Future<void> _showBlockingLoopExample1() async {
  final stream = _stream;
  await for (final value in stream) {
    print('Stream.value in a blocking loop: $value');
  }
}

Future<void> _showBlockingLoopExample2() async {
  var count = 0;
  while (true) {
    print('While.count: $count');
    count++;
    if (count == 3) {
      break;
    }
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}
