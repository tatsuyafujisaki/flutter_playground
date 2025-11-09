extension ListExtension<E> on List<E> {
  void prepend(E element) {
    insert(0, element);
  }
}
