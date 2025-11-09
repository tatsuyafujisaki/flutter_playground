import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../util/json/date_time_converter.dart';

part 'person.freezed.dart';
part 'person.g.dart';

@freezed
sealed class Person with _$Person {
  const factory Person({
    required String name,
    required int age,
    @DateTimeConverter() DateTime? lastUpdated,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}

void main() {
  final person = const Person(
    name: 'John',
    age: 42,
  ).copyWith(lastUpdated: DateTime.now());
  final map = person.toJson();
  debugPrint(map.toString());
  debugPrint(Person.fromJson(map).toString());
  debugPrint(jsonEncode(person)); // jsonEncode implicitly calls toJson.
}
