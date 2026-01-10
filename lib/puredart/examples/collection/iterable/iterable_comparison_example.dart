import 'dart:developer' as developer;

import 'package:collection/collection.dart';

void main() {
  final iterable1 = <String>['🍎', '🍊'] as Iterable<String>;
  final iterable2 = <String>['🍎', '🍊'] as Iterable<String>;
  final iterable3 = <String>['🍊', '🍎'] as Iterable<String>;

  const iterableEquality = IterableEquality<String>();

  developer.log((iterable1 == iterable2).toString()); // false
  developer.log(
    iterableEquality.equals(iterable1, iterable2).toString(),
  ); // true
  developer.log(
    iterableEquality.equals(iterable1, iterable3).toString(),
  ); // false
}
