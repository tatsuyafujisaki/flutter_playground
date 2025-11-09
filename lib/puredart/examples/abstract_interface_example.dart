import 'package:flutter/foundation.dart';

abstract interface class Fruit {
  static const apple = '🍎';
  static const orange = '🍊';
}

void main() {
  debugPrint(Fruit.apple); // 🍎
  debugPrint(Fruit.orange); // 🍊
}
