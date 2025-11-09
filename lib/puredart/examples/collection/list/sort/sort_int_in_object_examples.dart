import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

void main() {
  _sortIntInObject();
  _sortIntInObjectDescending1();
  _sortIntInObjectDescending2();
}

class _Person {
  _Person({required this.name, required this.age});
  final String name;
  final int age;

  @override
  String toString() => 'Person(name: $name, age: $age)';
}

List<_Person> _createPersonList() => <_Person>[
  _Person(name: 'c', age: 3),
  _Person(name: 'a', age: 1),
  _Person(name: 'b', age: 2),
];

void _sortIntInObject() {
  final list = _createPersonList()..sortBy<num>((person) => person.age);
  debugPrint(list.toString());
}

void _sortIntInObjectDescending1() {
  final list = _createPersonList()..sort((a, b) => b.age.compareTo(a.age));
  debugPrint(list.toString());
}

void _sortIntInObjectDescending2() {
  final list = _createPersonList()..sortBy<num>((x) => x.age * -1);
  debugPrint(list.toString());
}
