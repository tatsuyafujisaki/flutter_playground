Iterable<T> _flatten<T>(Iterable<Iterable<T>> xs) => xs.expand((x) => x);
Iterable<T> _filterNotNull<T>(Iterable<T?> xs) => xs.whereType<T>();

// ignore: unreachable_from_main
List<T> deepCopyList<T>(List<T> xs) => <T>[...xs];

// ignore: unreachable_from_main
Map<K, V> deepCopyMap<K, V>(Map<K, V> xs) => {...xs};

// ignore: unreachable_from_main
Set<T> deepCopySet<T>(Set<T> xs) => <T>{...xs};

void main() {
  final xs = [
    ['a'],
    ['b', 'c'],
    ['d'],
  ];

  print(_flatten(xs).toList()); // [a, b, c, d]

  final ys = <String?>['a', null, 'b'];

  print(_filterNotNull(ys).toList()); // [a, b]
}
