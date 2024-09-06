# How to invoke an `async` function in a non-`async` function
## Option 1
Use [WidgetsBinding.instance.addPostFrameCallback](https://api.flutter.dev/flutter/scheduler/SchedulerBinding/addPostFrameCallback.html).
```dart
WidgetsBinding.instance.addPostFrameCallback(
  (_) async =>  myAsyncFunction(),
);
```

## Option 2
Use [Future.delayed](https://api.dart.dev/stable/dart-async/Future/Future.delayed.html).
```dart
Future.delayed(
  Duration.zero,
  () async => await myAsyncFunction(),
);
```

# How to use [Future](https://api.dart.dev/stable/dart-async/Future-class.html) in a non-`async` function
Use [FutureBuilder](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html).
```dart
FutureBuilder<String>(
  future: myFuture,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data!);
    } else if (snapshot.hasError) {
      return Text(snapshot.error!.toString());
    } else {
      return Text(...);
    }
  },
)
```
