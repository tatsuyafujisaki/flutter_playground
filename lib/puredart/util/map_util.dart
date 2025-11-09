Map<String, Object?> _filterNotNull(Map<String, Object?> map) =>
// Map.from() makes a deep copy to keep the original map unchanged.
Map.from(map)..removeWhere((_, value) => value == null);

void main() {
  final map = <String, String?>{'A': 'a', 'B': null, 'C': 'c'};

  print(map); // {A: a, B: null, C: c}
  print(_filterNotNull(map)); // {A: a, C: c}
  print(map); // {A: a, B: null, C: c}
}
