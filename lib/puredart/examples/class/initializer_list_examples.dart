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
  print(person.firstName);
  print(person.lastName);
  print(person.fullName);
}
