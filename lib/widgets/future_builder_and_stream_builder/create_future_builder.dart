import 'package:flutter/material.dart';

FutureBuilder<T> createFutureBuilder<T>({
  required Widget Function(T) onData,
  Future<T>? future,
  Widget Function()? onError,
  Widget Function()? onElse,
}) =>
    FutureBuilder<T>(
      future: future,
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
