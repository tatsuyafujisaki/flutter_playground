import 'package:flutter/foundation.dart';

void main() {
  try {
    throw Exception('💀');
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrint(s.toString());
    // Uncomment the following in Flutter.
    // debugPrint(e.toString());
    // debugPrintStack(stackTrace: s);
  }
}
