import 'package:collection/collection.dart';

void main() {
  final iterable1 = <String>['🍎', '🍊'] as Iterable<String>;
  final iterable2 = <String>['🍎', '🍊'] as Iterable<String>;
  final iterable3 = <String>['🍊', '🍎'] as Iterable<String>;

  const iterableEquality = IterableEquality<String>();

  print(iterable1 == iterable2); // false
  print(iterableEquality.equals(iterable1, iterable2)); // true
  print(iterableEquality.equals(iterable1, iterable3)); // false
}
