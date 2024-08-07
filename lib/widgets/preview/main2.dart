import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: _MyStatelessWidget()));

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: IconButton(
            onPressed: () async => showModalBottomSheet<void>(
              context: context,
              builder: (context) => Column(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              // stretches the bottom sheet to full height.
              isScrollControlled: true,
              // avoids the bottom sheet of full height
              // from overlapping the status bar.
              useSafeArea: true,
            ),
            icon: const Icon(Icons.flutter_dash),
          ),
        ),
      );
}
