# How to print the Dart version
```dart
print(Platform.version); // x.x.x (stable)
```
https://api.flutter.dev/flutter/dart-io/Platform/version.html

# Required parameter / optional parameter / named parameter / positional (aka unnamed) parameter
## Example of positional (aka unnamed) parameters
```dart
// a ia a required unnamed parameter.
// b is an optional unnamed (aka positional) parameter whose default value is null.
// c is an optional unnamed (aka positional) parameter with a default value.
class MyClass {
  MyClass(this.a, [this.b, this.c = 'default!']) {
    print('a = $a, b = $b, c = $c');
  }
  String a;
  String? b;
  String c;
}

void myFunction(
  String a, [
  String? b,
  String c = 'default!',
]) {
  print('a = $a, b = $b, c = $c');
}

void main() {
  MyClass('a');
  MyClass('a', 'b');
  MyClass('a', 'b', 'c');

  myFunction('a');
  myFunction('a', 'b');
  myFunction('a', 'b', 'c');
}
```

## Example of named parameters
```dart
// a ia a required unnamed parameter.
// b ia a required named parameter.
// c is an optional named parameter whose default value is null.
// d is an optional named parameter with a default value.
class MyClass {
  MyClass(this.a, {required this.b, this.c, this.d = 'default!'}) {
    print('a = $a, b = $b, c = $c, d = $d');
  }
  String a;
  String b;
  String? c;
  String d;
}

void myFunction(
  String a, {
  required String b,
  String? c,
  String d = 'default!',
}) {
  print('a = $a, b = $b, c = $c, d = $d');
}

void main() {
  MyClass('a', b: 'b');
  MyClass('a', b: 'b', c: 'c');
  MyClass('a', b: 'b', c: 'c', d: 'd');

  myFunction('a', b: 'b');
  myFunction('a', b: 'b', c: 'c');
  myFunction('a', b: 'b', c: 'c', d: 'd');
}
```

# List
## How to clone (deep copy) a List
```dart
final list1 = <String>['🍎', '🍊'];
final list2 = List<String>.from(list1);
list2[0] = '🍏';
print(list1); // [🍎, 🍊]
print(list2); // [🍏, 🍊]
```

## How to convert `List<dynamic>` to `List<String>`
```dart
final list1 = <dynamic>['🍎'];
print(list1.runtimeType); // List<dynamic>

final list2 = List<String>.from(list1);
print(list2.runtimeType); // List<String>

// Not recommended way:
// > DON'T use cast() when a nearby operation will do
// https://dart.dev/effective-dart/usage#dont-use-cast-when-a-nearby-operation-will-do
// > AVOID using cast()
// https://dart.dev/effective-dart/usage#avoid-using-cast
final list3 = list1.cast<String>().toList();
print(list3.runtimeType); // List<String>
```

# How to get an item
```dart
final fruits = ['🍎'];
print(fruits.elementAtOrNull(0)); // 🍎
print(fruits.elementAtOrNull(1)); // null
print(fruits.firstWhereOrNull((element) => element == '🍏')); // null
print(fruits.firstWhere((element) => element == '🍏', orElse: () => 'Not found!')); // Not found!
```

# Difference between List and UnmodifiableListView
Operation|List|UnmodifiableListView
--|--|--
Can add or remove an item?|Yes|No
Can replace an item?|Yes|No

## Example of add/remove/modify on List
```dart
void main() {
  final fruits = ['🍎']
    ..remove('🍎')
    ..add('🍏');

  fruits[0] = '🍊';
  print(fruits); // ['🍊'];
}
```

## Example of add/remove/modify on UnmodifiableListView
```dart
void main() {
  final fruits = UnmodifiableListView(['🍎']);

  // throws "Unsupported operation: Cannot add to an unmodifiable list".
  // fruits.add('🍏');

  // throws "Unsupported operation: Cannot remove from an unmodifiable list".
  // fruits.remove('🍎');

  // throws "Unsupported operation: Cannot modify an unmodifiable list".
  // fruits[0] = '🍏';
}
```

# Set
## How to clone (deep copy) a Set
```dart
final set1 = <String>{'🍎', '🍊'};
final set2 = Set<String>.from(set1)
  ..remove('🍎')
  ..add('🍏');
print(set1); // {🍎, 🍊}
print(set2); // {🍊, 🍏}
```

# Map
## How do I get an item from a Map
```dart
void main() async {
  final map = <String, String>{'apple': '🍎'};
  print(map['apple']); // 🍎
  print(map['orange']); // null
}
```

## How to clone (deep copy) a Map
```dart
final map1 = <String, String>{'apple': '🍎', 'orange': '🍊'};
final map2 = Map<String, String>.from(map1);
map2['apple'] = '🍏';
print(map1); // {apple: 🍎, orange: 🍊}
print(map2); // {apple: 🍏, orange: 🍊}
```

# What in Dart is equivalent to scope functions﻿ in Kotlin?
Cascade notation (`..`, `?..`)

https://dart.dev/language/operators#cascade-notation
