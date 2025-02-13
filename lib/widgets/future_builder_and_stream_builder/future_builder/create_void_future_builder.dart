import 'package:flutter/material.dart';

FutureBuilder<void> createVoidFutureBuilder({
  required Widget Function() onData,
  Future<void>? future,
  Widget Function()? onError,
  Widget Function()? onElse,
}) => FutureBuilder<void>(
  future: future,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return onData();
    }
    if (snapshot.hasError) {
      debugPrint(snapshot.error.toString());
      debugPrintStack(stackTrace: snapshot.stackTrace);
      return onError?.call() ?? const Center(child: Icon(Icons.error));
    }
    return onElse?.call() ?? const Center(child: CircularProgressIndicator());
  },
);
