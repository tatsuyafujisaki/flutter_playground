import 'dart:developer' as developer;

void main() {
  _sortString();
  _sortStringDescending();
}

void _sortString() {
  final list = <String>['c', 'b', 'a']..sort();
  developer.log(list.toString()); // [a, b, c]
}

void _sortStringDescending() {
  final list = <String>['c', 'b', 'a']..sort((a, b) => b.compareTo(a));
  developer.log(list.toString()); // [c, b, a]
}
