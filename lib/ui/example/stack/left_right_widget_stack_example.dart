import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: _MyStatelessWidget()));

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => const MaterialApp(
    home: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[FlutterLogo(), FlutterLogo()],
    ),
  );
}
