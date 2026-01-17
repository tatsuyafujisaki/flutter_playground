extension StringExtension on String? {
  bool get isNullOrEmpty => this?.isNotEmpty ?? true;
  bool get isNeitherNullNorEmpty => this?.isNotEmpty ?? false;
}
