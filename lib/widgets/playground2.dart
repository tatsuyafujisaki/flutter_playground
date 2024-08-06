import 'package:flutter/material.dart';

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: IconButton(
            icon: const Icon(Icons.flutter_dash),
            onPressed: () async {
              await showModalBottomSheet<void>(
                context: context,
                builder: (context) => const Text('aaa'),
                useSafeArea: true,
              );
            },
          ),
        ),
      );
}

void main() => runApp(const _MyStatelessWidget());
