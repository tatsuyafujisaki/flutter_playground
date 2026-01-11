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
    case .unknown:
      developer.log('Unknown fruit!');
    case .apple:
      developer.log('Apple!');
    case .orange:
      developer.log('Orange!');
  }
}
