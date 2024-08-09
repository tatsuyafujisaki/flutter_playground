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
              builder: (_) => _BottomSheetContent(),
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

class _BottomSheetContent extends StatelessWidget {
  _BottomSheetContent();

  final indices = List<int>.generate(100, (index) => index).toList();

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
        heightFactor: 0.8,
        child: ListView(
          children: [
            for (final i in indices)
              Container(
                color: _getMaterialColor(Colors.amber, i),
                height: 50,
                child: Center(child: Text('Item $i')),
              ),
          ],
        ),
      );
}

Color? _getMaterialColor(MaterialColor materialColor, int index) {
  final i = index % 9;
  final value = i == 0 ? 50 : 100 * i;
  return materialColor[value];
}
