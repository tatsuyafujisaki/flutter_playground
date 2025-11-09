extension on String? {
  // ignore: unused_element
  bool get isNullOrEmpty => this?.isNotEmpty ?? true;
  // ignore: unused_element
  bool get isNeitherNullNorEmpty => this?.isNotEmpty ?? false;
}
