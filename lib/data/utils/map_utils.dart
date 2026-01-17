import 'dart:developer' as developer;

Map<String, Object?> _filterNotNull(Map<String, Object?> map) =>
    // Map.from() makes a deep copy to keep the original map unchanged.
    Map.from(map)..removeWhere((_, value) => value == null);

void main() {
  final map = <String, String?>{'A': 'a', 'B': null, 'C': 'c'};

  developer.log(map.toString()); // {A: a, B: null, C: c}
  developer.log(_filterNotNull(map).toString()); // {A: a, C: c}
  developer.log(map.toString()); // {A: a, B: null, C: c}
}
