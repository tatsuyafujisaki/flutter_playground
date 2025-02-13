import 'package:flutter/material.dart';

StreamBuilder<T> createStreamBuilder<T>({
  required Widget Function(T) onData,
  Stream<T>? stream,
  Widget Function()? onError,
  Widget Function()? onElse,
}) => StreamBuilder<T>(
  stream: stream,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return onData(snapshot.data as T);
    }
    if (snapshot.hasError) {
      debugPrint(snapshot.error.toString());
      debugPrintStack(stackTrace: snapshot.stackTrace);
      return onError?.call() ?? const Icon(Icons.error);
    }
    return onElse?.call() ?? const CircularProgressIndicator();
  },
);
