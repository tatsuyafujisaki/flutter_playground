import 'dart:developer' as developer;

String _trimWhitespace(String s) => s.replaceAll(RegExp(r'\s'), '');
void main() async {
  developer.log(_trimWhitespace('🍎 🍏　🍊\n🍇')); // 🍎🍏🍊🍇
}
