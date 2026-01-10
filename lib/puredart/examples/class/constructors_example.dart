import 'dart:developer' as developer;

/// https://dart.dev/language/constructors
class _MyClass {
  // Generative constructor
  _MyClass(this.sushi, [DateTime? dateTime])
    : myDateTime = dateTime ?? DateTime.now();

  // Named constructor
  _MyClass.myNamedConstructor1(this.sushi, [DateTime? dateTime])
    : myDateTime = dateTime ?? DateTime.now();

  // Named constructor
  _MyClass.myNamedConstructor2(String fish, String rice, [DateTime? dateTime])
    : sushi = fish + rice,
      myDateTime = dateTime ?? DateTime.now();

  // Redirecting constructor 1
  _MyClass.myRedirectingConstructor1(String sushi, [DateTime? dateTime])
    : this(sushi, dateTime ?? DateTime.now());

  // Redirecting constructor 2
  _MyClass.myRedirectingConstructor2(
    String fish,
    String rice, [
    DateTime? dateTime,
  ]) : this(fish + rice, dateTime ?? DateTime.now());

  final String sushi;
  final DateTime myDateTime;
}

void main() {
  developer.log(_MyClass('🍣').toString());
  developer.log(_MyClass.myNamedConstructor1('🍣').toString());
  developer.log(_MyClass.myNamedConstructor2('🐟', '🍚').toString());
  developer.log(_MyClass.myRedirectingConstructor1('🍣').toString());
  developer.log(_MyClass.myRedirectingConstructor2('🐟', '🍚').toString());
}
