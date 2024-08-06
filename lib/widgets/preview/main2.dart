import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: _MyStatelessWidget()));

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: IconButton(
            onPressed: () async => showModalBottomSheet<void>(
              context: context,
              builder: (context) => IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
              // stretches the bottom sheet to the top.
              isScrollControlled: true,
            ),
            icon: const Icon(Icons.flutter_dash),
          ),
        ),
      );
}
