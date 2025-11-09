void main() {
  _sortString();
  _sortStringDescending();
}

void _sortString() {
  final list = <String>['c', 'b', 'a']..sort();
  print(list); // [a, b, c]
}

void _sortStringDescending() {
  final list = <String>['c', 'b', 'a']..sort((a, b) => b.compareTo(a));
  print(list); // [c, b, a]
}
