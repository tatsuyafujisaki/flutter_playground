import 'package:collection/collection.dart';

void main() {
  final list1 = <String>['🍎', '🍊'];
  final list2 = <String>['🍎', '🍊'];
  final list3 = <String>['🍊', '🍎'];

  const listEquality = ListEquality<String>();

  print(list1 == list2); // false
  print(listEquality.equals(list1, list2)); // true
  print(listEquality.equals(list1, list3)); // false
}
