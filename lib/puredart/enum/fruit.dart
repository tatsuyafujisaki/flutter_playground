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
      print('Unknown fruit!');
    case Fruit.apple:
      print('Apple!');
    case Fruit.orange:
      print('Orange!');
  }
}
