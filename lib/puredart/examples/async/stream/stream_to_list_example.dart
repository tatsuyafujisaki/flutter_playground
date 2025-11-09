import 'dart:async';

import 'package:flutter/foundation.dart';

void main() async {
  final stream = Stream.fromIterable(['a', 'b', 'c']);
  final list = await stream.map((e) => e.toUpperCase()).toList();
  debugPrint(list.toString()); // [A, B, C]
}
