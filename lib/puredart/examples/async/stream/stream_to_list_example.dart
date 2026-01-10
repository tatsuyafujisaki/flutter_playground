import 'dart:async';
import 'dart:developer' as developer;

void main() async {
  final stream = Stream.fromIterable(['a', 'b', 'c']);
  final list = await stream.map((e) => e.toUpperCase()).toList();
  developer.log(list.toString()); // [A, B, C]
}
