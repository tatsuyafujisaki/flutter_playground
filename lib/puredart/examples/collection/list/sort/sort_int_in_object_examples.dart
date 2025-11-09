import 'package:collection/collection.dart';

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
  print(list);
}

void _sortIntInObjectDescending1() {
  final list = _createPersonList()..sort((a, b) => b.age.compareTo(a.age));
  print(list);
}

void _sortIntInObjectDescending2() {
  final list = _createPersonList()..sortBy<num>((x) => x.age * -1);
  print(list);
}
