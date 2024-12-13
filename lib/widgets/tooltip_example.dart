import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          body: _MyStatelessWidget(),
          backgroundColor: Colors.lime,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(
            key: key,
            message: 'Tooltip!',
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            textStyle: TextStyle(
              color: Colors.black,
            ),
            child: FlutterLogo(),
          ),
          Tooltip(
            key: key,
            message: 'Tooltip!',
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            textStyle: TextStyle(
              color: Colors.black,
            ),
            child: FlutterLogo(),
          ),
        ],
      ),
    );
  }
}
