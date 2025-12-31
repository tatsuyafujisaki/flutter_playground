import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() =>
    runApp(const ProviderScope(child: MaterialApp(home: _MyStatelessWidget())));

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '🍎',
          style: TextStyle(backgroundColor: Colors.cyan),
          textAlign: TextAlign.end,
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            '🍏',
            style: TextStyle(backgroundColor: Colors.cyan),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Text(
              '🍊',
              style: TextStyle(backgroundColor: Colors.cyan),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    ),
  );
}
