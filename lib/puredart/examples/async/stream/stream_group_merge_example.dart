import 'dart:async';
import 'dart:developer' as developer;

import 'package:async/async.dart';

void main() async {
  final stream1 = Stream.periodic(
    const Duration(seconds: 1),
    (count) => ['🍎', '🍊', '🍏'][count],
  ).take(3);

  final stream2 = Stream.periodic(
    const Duration(seconds: 1),
    (count) => ['🐶', '🐱', '🦊'][count],
  ).take(3);

  StreamGroup.merge<String>([
    stream1,
    stream2,
  ]).listen((event) => developer.log('onData: $event'));
}
