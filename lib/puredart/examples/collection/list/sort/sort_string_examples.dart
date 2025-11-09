import 'package:flutter/foundation.dart';

void main() {
  _sortString();
  _sortStringDescending();
}

void _sortString() {
  final list = <String>['c', 'b', 'a']..sort();
  debugPrint(list.toString()); // [a, b, c]
}

void _sortStringDescending() {
  final list = <String>['c', 'b', 'a']..sort((a, b) => b.compareTo(a));
  debugPrint(list.toString()); // [c, b, a]
}
