import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';

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
  ]).listen((event) => debugPrint('onData: $event'));
}
