class _MyAsyncConstructorClass {
  _MyAsyncConstructorClass._(this.data);

  static Future<_MyAsyncConstructorClass> create(String emoji) async {
    final data = await Future<String>.value(emoji);
    return _MyAsyncConstructorClass._(data);
  }

  final String data;
}

void main() async {
  final myClass = await _MyAsyncConstructorClass.create('🍎');
  print(myClass.data); // 🍎
}
