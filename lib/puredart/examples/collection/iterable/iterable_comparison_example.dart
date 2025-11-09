import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

void main() {
  final iterable1 = <String>['🍎', '🍊'] as Iterable<String>;
  final iterable2 = <String>['🍎', '🍊'] as Iterable<String>;
  final iterable3 = <String>['🍊', '🍎'] as Iterable<String>;

  const iterableEquality = IterableEquality<String>();

  debugPrint((iterable1 == iterable2).toString()); // false
  debugPrint(iterableEquality.equals(iterable1, iterable2).toString()); // true
  debugPrint(iterableEquality.equals(iterable1, iterable3).toString()); // false
}
