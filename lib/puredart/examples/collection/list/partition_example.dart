void main() {
  final xs = List.generate(5, (x) => x);
  final (evens, odds) = xs.partition((x) => x.isEven);

  print(evens); // [0, 2, 4]
  print(odds); // [1, 3]
}

extension<T> on Iterable<T> {
  (List<T>, List<T>) partition(bool Function(T) predicate) {
    final list1 = <T>[];
    final list2 = <T>[];

    for (final element in this) {
      if (predicate(element)) {
        list1.add(element);
      } else {
        list2.add(element);
      }
    }

    return (list1, list2);
  }
}
