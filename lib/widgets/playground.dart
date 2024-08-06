import 'package:flutter/material.dart';

void main() => runApp(const _MyStatelessWidget());

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: FlutterLogo(),
      );
}
