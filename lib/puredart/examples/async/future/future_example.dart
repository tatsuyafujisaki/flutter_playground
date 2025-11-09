import 'package:flutter/foundation.dart';

void main() async {
  final future1 = Future<String>.value('🍎');
  final future2 = Future<String>.error('☠️');

  await _printFuture(future1);
  debugPrint('--');
  await _printFuture(future2);
  debugPrint('--');
  await _printFuture(future1, deliberatelyThrowErrorInsideThen: true);
}

Future<void> _printFuture<T>(
  Future<T> future, {
  bool deliberatelyThrowErrorInsideThen = false,
}) async {
  await future
      .then(
        (value) {
          if (deliberatelyThrowErrorInsideThen) {
            throw Exception('This exception originate in `then`.');
          }
          debugPrint('then: $value');
        },
        onError: (Object? error) {
          debugPrint('then.onError: $error');
        },
      )
      .catchError((Object? error) {
        debugPrint('catchError: $error');
      })
      .whenComplete(() => debugPrint('whenComplete'));
}
