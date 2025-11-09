import 'package:flutter/foundation.dart';

String _trimWhitespace(String s) => s.replaceAll(RegExp(r'\s'), '');
void main() async {
  debugPrint(_trimWhitespace('🍎 🍏　🍊\n🍇')); // 🍎🍏🍊🍇
}
