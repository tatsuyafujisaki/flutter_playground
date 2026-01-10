import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(
  ProviderScope(
    child: MaterialApp(home: Scaffold(body: _MyStatelessWidget())),
  ),
);

class _MyStatelessWidget extends StatelessWidget {
  final countStream = Stream<String>.periodic(
    const Duration(seconds: 1),
    (count) => '$count!',
  );

  @override
  Widget build(BuildContext context) => Center(
    child: StreamBuilder<String>(
      stream: countStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!);
        }
        if (snapshot.hasError) {
          developer.log(snapshot.error.toString());
          developer.log(snapshot.stackTrace.toString());
          return const Icon(Icons.error);
        }
        return const CircularProgressIndicator();
      },
    ),
  );
}
