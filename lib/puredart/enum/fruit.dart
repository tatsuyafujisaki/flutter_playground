import 'dart:developer' as developer;

import 'package:collection/collection.dart';

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
      developer.log('Unknown fruit!');
    case Fruit.apple:
      developer.log('Apple!');
    case Fruit.orange:
      developer.log('Orange!');
  }
}
