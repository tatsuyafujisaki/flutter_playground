import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
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

  developer.log(fruits.toString());
  fruits.removeWhere((fruits) => fruits.emoji == '🍏');
  developer.log(fruits.toString());
}
