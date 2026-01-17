import 'dart:developer' as developer;

import 'package:flutter/material.dart';

FutureBuilder<T> createNonVoidFutureBuilder<T>({
  required Widget Function(T) onData,
  Future<T>? future,
  Widget Function()? onError,
  Widget Function()? onElse,
}) => FutureBuilder<T>(
  future: future,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return onData(snapshot.data as T);
    }
    if (snapshot.hasError) {
      developer.log(snapshot.error.toString());
      developer.log(snapshot.stackTrace.toString());
      return onError?.call() ?? const Center(child: Icon(Icons.error));
    }
    return onElse?.call() ?? const Center(child: CircularProgressIndicator());
  },
);
