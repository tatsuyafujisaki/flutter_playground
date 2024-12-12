import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          body: _MyStatelessWidget(),
        ),
      ),
    );

class _MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<TooltipState>();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => key.currentState?.ensureTooltipVisible(),
    );

    return Center(
      child: Tooltip(
        key: key,
        message: 'Tooltip!',
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        textStyle: TextStyle(
          color: Colors.yellow,
        ),
        child: FlutterLogo(),
      ),
    );
  }
}
