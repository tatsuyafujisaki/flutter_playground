import 'dart:async';

void main() async {
  final stream = Stream.fromIterable(['a', 'b', 'c']);
  final list = await stream.map((e) => e.toUpperCase()).toList();
  print(list); // [A, B, C]
}
