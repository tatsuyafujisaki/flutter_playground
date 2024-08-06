import 'package:flutter/material.dart';

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: Scaffold(
          body: BottomSheetExample(),
        ),
      );
}

class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: ElevatedButton(
          child: const Text('showModalBottomSheet'),
          onPressed: () async {
            await showModalBottomSheet<void>(
              context: context,
              builder: (context) => Container(
                height: 200,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}

void main() => runApp(const _MyStatelessWidget());
