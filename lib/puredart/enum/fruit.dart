import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

enum Fruit {
  unknown(''),
  apple('🍎'),
  orange('🍊');

  const Fruit(this.emoji);

  factory Fruit.of(String emoji) =>
      values.firstWhereOrNull((value) => value.emoji == emoji) ?? unknown;

  final String emoji;
}

void main() {
  final fruit = Fruit.of('🍎');

  switch (fruit) {
    case Fruit.unknown:
      debugPrint('Unknown fruit!');
    case Fruit.apple:
      debugPrint('Apple!');
    case Fruit.orange:
      debugPrint('Orange!');
  }
}
