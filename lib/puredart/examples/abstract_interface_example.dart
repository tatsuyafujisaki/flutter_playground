import 'dart:developer' as developer;

abstract interface class Fruit {
  static const apple = '🍎';
  static const orange = '🍊';
}

void main() {
  developer.log(Fruit.apple); // 🍎
  developer.log(Fruit.orange); // 🍊
}
