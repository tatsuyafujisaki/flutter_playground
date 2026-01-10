import 'dart:developer' as developer;

void main() async {
  final future1 = Future<String>.value('🍎');
  final future2 = Future<String>.error('☠️');

  await _printFuture(future1);
  developer.log('--');
  await _printFuture(future2);
  developer.log('--');
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
          developer.log('👀then.onValue: $value');
        },
        onError: (Object error, StackTrace stackTrace) {
          developer.log('👀then.onError', error: error, stackTrace: stackTrace);
        },
      )
      .catchError((Object error, StackTrace stackTrace) {
        developer.log('👀catchError', error: error, stackTrace: stackTrace);
      })
      .whenComplete(() => developer.log('👀whenComplete'));
}
