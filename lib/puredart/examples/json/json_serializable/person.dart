import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

// Specify "filedname: FieldRename.snake" as follows if you need to input
// and output JSON whose keys are snake_case.
// @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
@JsonSerializable(explicitToJson: true)
class _Person {
  _Person({required this.firstName, required this.lastName});

  factory _Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  final String? firstName;
  final String lastName;

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

void _print(_Person person) {
  debugPrint(person.firstName.toString());
  debugPrint(person.lastName);
  debugPrint(person.toJson().toString());
}

void main() {
  final map = <String, dynamic>{'lastName': 'Smith'};
  _print(_Person.fromJson(map));
}
