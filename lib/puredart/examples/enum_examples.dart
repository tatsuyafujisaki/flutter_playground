enum _Fruit { apple, orange }

void main() {
  print(_Fruit.values.elementAtOrNull(0)); // Apple
  print(_Fruit.values.elementAtOrNull(1)); // Orange
  print(_Fruit.values.elementAtOrNull(2)); // null
  // print(_Fruit.values.elementAtOrNull(null)); // Compilation error
}
