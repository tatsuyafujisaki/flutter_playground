import 'dart:developer' as developer;

class _Person {
  _Person({
    required this.firstName,
    required String middleName,
    required this.lastName,
  }) : fullName = '$firstName $middleName $lastName';

  String firstName;
  String lastName;
  String fullName;
}

void main() {
  final person = _Person(
    firstName: 'Christopher',
    middleName: 'Robin',
    lastName: 'Milne',
  );
  developer.log(person.firstName);
  developer.log(person.lastName);
  developer.log(person.fullName);
}
