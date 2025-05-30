import 'package:flutter/material.dart';
import 'create_non_void_future_builder.dart';

void main() => runApp(MaterialApp(home: Scaffold(body: _MyStatelessWidget())));

class _MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => createNonVoidFutureBuilder<String>(
    future: Future<String>.delayed(const Duration(seconds: 5), () => '🍎'),
    onData: (data) => Center(child: Text(data)),
  );
}
