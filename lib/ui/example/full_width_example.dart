import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

@Preview()
Widget preview() => const _MyStatelessWidget();

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
