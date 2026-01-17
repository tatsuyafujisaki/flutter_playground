import 'dart:async';

void main() async {
  final streamController = StreamController<void>()
    ..stream.listen((event) {})
    // Attempting to add the second listener to a non-broadcast StreamController
    // results in the following error:
    // > StateError (Bad state: Stream has already been listened to.)
    ..stream.listen((event) {});

  await streamController.close();
}
