import 'package:flutter/foundation.dart';

enum _Fruit { apple, orange }

void main() {
  debugPrint(_Fruit.values.elementAtOrNull(0).toString()); // Apple
  debugPrint(_Fruit.values.elementAtOrNull(1).toString()); // Orange
  debugPrint(_Fruit.values.elementAtOrNull(2).toString()); // null
  // debugPrint(_Fruit.values.elementAtOrNull(null).toString()); // Compilation error
}
