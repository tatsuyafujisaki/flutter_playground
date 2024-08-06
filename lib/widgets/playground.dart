import 'package:flutter/material.dart';

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: FlutterLogo(),
      );
}

void main() => runApp(const _MyStatelessWidget());
