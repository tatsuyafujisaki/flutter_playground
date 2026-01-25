import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

@Preview()
Widget preview() => _MyStatelessWidget();

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
            decoration: const BoxDecoration(color: Colors.white),
            textStyle: const TextStyle(color: Colors.black),
            child: const FlutterLogo(),
          ),
          Tooltip(
            key: key,
            message: 'Tooltip!',
            decoration: const BoxDecoration(color: Colors.white),
            textStyle: const TextStyle(color: Colors.black),
            child: const FlutterLogo(),
          ),
        ],
      ),
    );
  }
}
