import 'dart:developer' as developer;

/// https://dart.dev/language/constructors
class _MyClass {
  // Generative constructor
  _MyClass(this.sushi, [DateTime? dateTime]) : myDateTime = dateTime ?? .now();

  // Named constructor
  _MyClass.myNamedConstructor1(this.sushi, [DateTime? dateTime])
    : myDateTime = dateTime ?? .now();

  // Named constructor
  _MyClass.myNamedConstructor2(String fish, String rice, [DateTime? dateTime])
    : sushi = fish + rice,
      myDateTime = dateTime ?? .now();

  // Redirecting constructor 1
  _MyClass.myRedirectingConstructor1(String sushi, [DateTime? dateTime])
    : this(sushi, dateTime ?? .now());

  // Redirecting constructor 2
  _MyClass.myRedirectingConstructor2(
    String fish,
    String rice, [
    DateTime? dateTime,
  ]) : this(fish + rice, dateTime ?? .now());

  final String sushi;
  final DateTime myDateTime;
}

void main() {
  final myClass1 = _MyClass('🍣');
  developer.log(myClass1.toString());
  final myClass2 = _MyClass.myNamedConstructor1('🍣');
  developer.log(myClass2.toString());
  final myClass3 = _MyClass.myNamedConstructor2('🐟', '🍚');
  developer.log(myClass3.toString());
  final myClass4 = _MyClass.myRedirectingConstructor1('🍣');
  developer.log(myClass4.toString());
  final myClass5 = _MyClass.myRedirectingConstructor2('🐟', '🍚');
  developer.log(myClass5.toString());
}
