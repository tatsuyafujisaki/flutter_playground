import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../examples/freezed/person.dart';

// ignore: unreachable_from_main
Map<String, dynamic> jsonDecodeToMap(String json) {
  try {
    return jsonDecode(json) as Map<String, dynamic>;
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrint(s.toString());
  }
  return <String, dynamic>{};
}

// ignore: unreachable_from_main
String minifyJson(String json) => jsonEncode(jsonDecode(json));

T _parseObject<T>(
  String json,
  T Function(Map<String, dynamic> json) toElement,
) => toElement(jsonDecode(json) as Map<String, dynamic>);

List<T> _parseArray<T>(
  String json,
  T Function(Map<String, dynamic> json) toElement,
) =>
    List<Map<String, dynamic>>.from(
      jsonDecode(json) as Iterable,
    ).map(toElement).toList();

void main() {
  debugPrint(
    _parseObject('{ "name": "John", "age": 42 }', Person.fromJson).toString(),
  );
  debugPrint(
    _parseArray(
      '[{ "name": "John", "age": 42 }, { "name": "Jane", "age": 18 }]',
      Person.fromJson,
    ).toString(),
  );
}
