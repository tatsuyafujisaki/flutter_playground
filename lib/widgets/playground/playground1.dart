import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(
        home: _MyStatelessWidget(),
      ),
    );

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => const FlutterLogo();
}
