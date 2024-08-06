import 'package:flutter/material.dart';

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlutterLogo(),
            FlutterLogo(),
          ],
        ),
      );
}

void main() => runApp(const _MyStatelessWidget());
