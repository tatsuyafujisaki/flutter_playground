void main() {
  _sortInt();
  _sortIntDescending();
}

void _sortInt() {
  final list = <int>[3, 1, 2]..sort();
  print(list); // [1, 2, 3]
}

void _sortIntDescending() {
  final list = <int>[3, 1, 2]..sort((a, b) => b.compareTo(a));
  print(list); // [3, 2, 1]
}
