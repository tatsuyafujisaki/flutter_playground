import 'dart:convert';

void _printJsonRootType(String json) {
  print((jsonDecode(json) as Map<String, dynamic>).runtimeType);
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
