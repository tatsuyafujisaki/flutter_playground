import 'dart:convert';
import 'dart:developer' as developer;


void _logJsonRootType(String json) {
  developer.log(
    (jsonDecode(json) as Map<String, dynamic>).runtimeType.toString(),
  );
}

void main() {
  _logJsonRootType('{ "name": "Jane", "age": 18 }'); // _Map<String, dynamic>

  _logJsonRootType('["a", "b"]'); // List<dynamic>

  _logJsonRootType('-1'); // int
  _logJsonRootType('3.14'); // double

  _logJsonRootType('"abc"'); // String

  _logJsonRootType('true'); // bool
  _logJsonRootType('false'); // bool

  _logJsonRootType('null'); // Null
}
