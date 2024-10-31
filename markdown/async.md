# Future
## When to use which: [ignore](https://api.flutter.dev/flutter/dart-async/FutureExtensions/ignore.html), [FutureBuilder](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html), [WidgetsBinding.instance.addPostFrameCallback](https://api.flutter.dev/flutter/scheduler/SchedulerBinding/addPostFrameCallback.html), or [Future.delayed](https://api.dart.dev/stable/dart-async/Future/Future.delayed.html), as a way to invoke an `async` function in a non-`async` function
1. If you want to ignore the result and not have the global error handler catch the error, use [ignore](https://api.flutter.dev/flutter/dart-async/FutureExtensions/ignore.html).
1. If you want to create a Widget from a Future, use [FutureBuilder](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html).
1. If you want to call an `async` function in a Widget, use [WidgetsBinding.instance.addPostFrameCallback](https://api.flutter.dev/flutter/scheduler/SchedulerBinding/addPostFrameCallback.html).
  ```dart
  WidgetsBinding.instance.addPostFrameCallback(
    (_) async => myAsyncFunction(),
  );
  ```
1. Otherwise, use [Future.delayed](https://api.dart.dev/stable/dart-async/Future/Future.delayed.html) or [unawaited](https://api.dart.dev/stable/dart-async/unawaited.html).

# Stream
## When to use which: [StreamBuilder](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html), [await for](https://dart.dev/libraries/async/using-streams#receiving-stream-events), or [Stream.listen](https://api.flutter.dev/flutter/dart-async/Stream/listen.html)
1. If you want to create a Widget from a Stream, use [StreamBuilder](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html).
1. If you want to wait for the stream to finish, use [await for](https://dart.dev/libraries/async/using-streams#receiving-stream-events).
1. Otherwise, use [Stream.listen](https://api.flutter.dev/flutter/dart-async/Stream/listen.html).

If you are using both [Stream.listen](https://api.flutter.dev/flutter/dart-async/Stream/listen.html) and [StreamSubscription.asFuture](https://api.flutter.dev/flutter/dart-async/StreamSubscription/asFuture.html), you may want to replace them with [await for](https://dart.dev/libraries/async/using-streams#receiving-stream-events) for simplicity.
