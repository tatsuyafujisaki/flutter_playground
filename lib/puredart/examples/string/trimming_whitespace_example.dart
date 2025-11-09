String _trimWhitespace(String s) => s.replaceAll(RegExp(r'\s'), '');
void main() async {
  print(_trimWhitespace('🍎 🍏　🍊\n🍇')); // 🍎🍏🍊🍇
}
