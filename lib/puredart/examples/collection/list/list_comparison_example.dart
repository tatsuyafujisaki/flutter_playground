import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

void main() {
  final list1 = <String>['🍎', '🍊'];
  final list2 = <String>['🍎', '🍊'];
  final list3 = <String>['🍊', '🍎'];

  const listEquality = ListEquality<String>();

  debugPrint((list1 == list2).toString()); // false
  debugPrint(listEquality.equals(list1, list2).toString()); // true
  debugPrint(listEquality.equals(list1, list3).toString()); // false
}
