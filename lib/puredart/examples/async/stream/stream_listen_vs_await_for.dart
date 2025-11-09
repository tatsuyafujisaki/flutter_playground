void main() async {
  print('-- Example of "Stream.listen(...)" --');
  await showListenExample();
  print('-- Example of "await for" --');
  await showAwaitForExample();
}

Stream<String> _createStream() => Stream<String>.periodic(
  const Duration(milliseconds: 100),
  (count) => '$count!',
).take(3);

Future<void> showListenExample() async {
  print('👀Starts consuming a stream.');
  final subscription = _createStream().listen((data) => print('👀$data'));
  // Unlike "await for", listen() does not wait until the stream is done.
  // Without "await subscription.asFuture(...)",
  // the app will not wait for the stream to finish.
  final result = await subscription.asFuture<String>(
    '👀Finishes consuming a stream.',
  );
  print(result);

  await subscription.cancel();
}

Future<void> showAwaitForExample() async {
  print('👀Starts consuming a stream.');
  // Unlike listen(), "await for" waits until the stream is done.
  //
  // > When reading events using an await for loop, the loops stops when the
  // > stream is done.
  // https://dart.dev/libraries/async/using-streams#error-events
  await for (final data in _createStream()) {
    print('👀$data');
  }
  print('👀Finishes consuming a stream.');
}
