import 'dart:developer' as developer;

void main() {
  _sortInt();
  _sortIntDescending();
}

void _sortInt() {
  final list = <int>[3, 1, 2]..sort();
  developer.log(list.toString()); // [1, 2, 3]
}

void _sortIntDescending() {
  final list = <int>[3, 1, 2]..sort((a, b) => b.compareTo(a));
  developer.log(list.toString()); // [3, 2, 1]
}
