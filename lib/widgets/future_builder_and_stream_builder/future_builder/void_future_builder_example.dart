import 'package:flutter/material.dart';
import 'create_void_future_builder.dart';

void main() => runApp(MaterialApp(home: Scaffold(body: _MyStatelessWidget())));

class _MyStatelessWidget extends StatelessWidget {
  final _future = Future<void>.delayed(const Duration(seconds: 5), () {});

  @override
  Widget build(BuildContext context) => createVoidFutureBuilder(
    future: _future,
    onData: () => const Center(child: FlutterLogo()),
  );
}
