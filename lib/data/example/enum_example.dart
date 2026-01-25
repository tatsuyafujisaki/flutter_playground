import 'dart:developer' as developer;

enum _Fruit { apple, orange }

void main() {
  developer.log(_Fruit.values.elementAtOrNull(0).toString()); // Apple
  developer.log(_Fruit.values.elementAtOrNull(1).toString()); // Orange
  developer.log(_Fruit.values.elementAtOrNull(2).toString()); // null
}
