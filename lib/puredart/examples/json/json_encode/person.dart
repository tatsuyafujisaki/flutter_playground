import 'dart:convert';

import 'package:flutter/foundation.dart';

class _Person {
  _Person(this.name, this.age);

  _Person.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String,
      age = json['age'] as int;
  final String name;
  final int age;

  // jsonEncode() implicitly calls toJson().
  Map<String, dynamic> toJson() => {'name': name, 'age': 10};
}

void main() {
  const json = '{"name": "Nobita", "age": 10}';
  final map = jsonDecode(json) as Map<String, dynamic>;
  final user = _Person.fromJson(map);
  final encoded = jsonEncode(user);
  debugPrint(encoded);
}
