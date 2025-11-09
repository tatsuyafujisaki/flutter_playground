import 'dart:convert';

import 'package:flutter/foundation.dart';

void _printJsonRootType(String json) {
  debugPrint((jsonDecode(json) as Map<String, dynamic>).runtimeType.toString());
}

void main() {
  _printJsonRootType('{ "name": "Jane", "age": 18 }'); // _Map<String, dynamic>

  _printJsonRootType('["a", "b"]'); // List<dynamic>

  _printJsonRootType('-1'); // int
  _printJsonRootType('3.14'); // double

  _printJsonRootType('"abc"'); // String

  _printJsonRootType('true'); // bool
  _printJsonRootType('false'); // bool

  _printJsonRootType('null'); // Null
}
