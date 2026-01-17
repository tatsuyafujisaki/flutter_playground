import 'dart:developer' as developer;

abstract interface class Fruit {
  static const apple = '🍎';
  static const orange = '🍊';
}

void main() {
  const apple = Fruit.apple; // 🍎
  const orange = Fruit.orange; // 🍊
  developer.log(apple);
  developer.log(orange);
}
