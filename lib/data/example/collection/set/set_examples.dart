import 'dart:developer' as developer;

void _addOrRemove<T>(Set<T> set, T value) {
  if (!set.add(value)) {
    set.remove(value);
  }
}

void main() {
  final fruits = {'🍎', '🍊'};
  _addOrRemove(fruits, '🍏');
  developer.log(fruits.toString());
  _addOrRemove(fruits, '🍏');
  developer.log(fruits.toString());
}
