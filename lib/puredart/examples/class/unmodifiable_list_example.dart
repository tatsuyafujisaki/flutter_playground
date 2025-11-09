class _MyClass {
  final _myNonFinalString = '🍎';
  // Trying to replace myNonFinalString itself outside the class will cause a
  // buid error.
  // myTemplateClass.myNonFinalString = '🍏'; // causes a build error.
  String get myFinalString => _myNonFinalString;

  final List<String> _myList = ['🍎'];

  // Tring to replace myList itself outside the class will cause a buid error.
  // myTemplateClass.myList = ['🍏']; // causes a build error.
  //
  // Adding, deleting, or replacing items in myList outside of the class will
  // work.
  // myTemplateClass.myList.clear();
  // myTemplateClass.myList.addAll(['🍏']);
  List<String> get myList => _myList;

  // Tring to replace myUnmodifiableList itself outside the class will cause a
  // buid error.
  // myTemplateClass.myUnmodifiableList = ['🍏']; // causes a build error.
  //
  // Trying to add, delete, or replace items in myList outside the class ...
  // ... will throw a runtime exception.
  // myTemplateClass.myUnmodifiableList.clear();
  // myTemplateClass.myUnmodifiableList.addAll(['🍏']);
  List<String> get myUnmodifiableList => List<String>.unmodifiable(_myList);
}

void main() {
  final myTemplateClass = _MyClass();

  // myTemplateClass.myNonFinalString = '🍏'; // causes a build error.
  print(myTemplateClass.myFinalString);

  // myTemplateClass.myList = ['🍏']; // causes a build error.
  myTemplateClass.myList.clear();
  myTemplateClass.myList.addAll(['🍏']);
  print(myTemplateClass.myList);

  // myTemplateClass.myUnmodifiableList = ['🍏']; // causes a build error.
  // myTemplateClass.myUnmodifiableList.clear(); // throws a runtime exception.
  // myTemplateClass.myUnmodifiableList.addAll(['🍏']); // throws a runtime exception.
  print(myTemplateClass.myUnmodifiableList);
}
