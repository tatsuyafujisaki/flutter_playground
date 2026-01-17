import 'dart:developer' as developer;

import 'package:collection/collection.dart';

void main() {
  final list1 = <String>['🍎', '🍊'];
  final list2 = <String>['🍎', '🍊'];
  final list3 = <String>['🍊', '🍎'];

  const listEquality = ListEquality<String>();

  developer.log((list1 == list2).toString()); // false
  developer.log(listEquality.equals(list1, list2).toString()); // true
  developer.log(listEquality.equals(list1, list3).toString()); // false
}
