class _MyTemplateClass {
  _MyTemplateClass(this._myList, [DateTime? dateTime])
    : myDateTime = dateTime ?? DateTime.now();

  final List<String> _myList;
  List<String> get myList => List<String>.unmodifiable(_myList);

  final DateTime myDateTime;
}

void main() {
  final myTemplateClass = _MyTemplateClass(['🍎', '🍊']);
  print(myTemplateClass.myList);
  print(myTemplateClass.myDateTime);
}
