# How to invoke an `async` function in a non-`async` function
Pseudo-flowchart
1. If you want to create a [Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html) from a [Future](https://api.dart.dev/stable/dart-async/Future-class.html) or [Stream](https://api.flutter.dev/flutter/dart-async/Stream-class.html), use [FutureBuilder](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html) or [StreamBuilder](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html).
2. If you want to call an `async` function in a [Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html), use [WidgetsBinding.instance.addPostFrameCallback](https://api.flutter.dev/flutter/scheduler/SchedulerBinding/addPostFrameCallback.html).
  ```dart
  WidgetsBinding.instance.addPostFrameCallback(
    (_) async => myAsyncFunction(),
  );
  ```
3. Otherwise, use [Future.delayed](https://api.dart.dev/stable/dart-async/Future/Future.delayed.html).
