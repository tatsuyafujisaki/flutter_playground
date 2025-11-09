import 'package:flutter/foundation.dart';

void _addOrRemove<T>(Set<T> set, T value) {
  if (!set.add(value)) {
    set.remove(value);
  }
}

void main() {
  final fruits = {'🍎', '🍊'};
  _addOrRemove(fruits, '🍏');
  debugPrint(fruits.toString());
  _addOrRemove(fruits, '🍏');
  debugPrint(fruits.toString());
}
