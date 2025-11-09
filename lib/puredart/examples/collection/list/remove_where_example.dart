import 'package:freezed_annotation/freezed_annotation.dart';

part 'remove_where_example.freezed.dart';

@freezed
sealed class Fruit with _$Fruit {
  const factory Fruit({required String emoji}) = _Fruit;
}

void main() {
  final fruits = [
    const Fruit(emoji: '🍎'),
    const Fruit(emoji: '🍏'),
    const Fruit(emoji: '🍊'),
  ];

  print(fruits);
  fruits.removeWhere((fruits) => fruits.emoji == '🍏');
  print(fruits);
}
