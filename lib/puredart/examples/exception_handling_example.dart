void main() {
  try {
    throw Exception('💀');
  } on Exception catch (e, s) {
    print(e);
    print(s);
    // Uncomment the following in Flutter.
    // debugPrint(e.toString());
    // debugPrintStack(stackTrace: s);
  }
}
