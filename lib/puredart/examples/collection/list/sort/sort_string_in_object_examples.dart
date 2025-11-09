import 'package:collection/collection.dart';

void main() {
  _sortStringInObject();
  _sortStringInObjectDescending();
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

void _sortStringInObject() {
  final list = _createPersonList()..sortBy((person) => person.name);
  print(list);
}

void _sortStringInObjectDescending() {
  final list = _createPersonList()..sort((a, b) => b.name.compareTo(a.name));
  print(list);
}
