import 'package:flutter/material.dart';
import 'package:flutter_playground/util/color_utils.dart';

void main() => runApp(const MaterialApp(home: _MyStatelessWidget()));

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: IconButton(
        onPressed:
            () async => showModalBottomSheet<void>(
              context: context,
              builder: (_) => _BottomSheetContent(),
            ),
        icon: const Icon(Icons.open_in_new),
      ),
    ),
  );
}

class _BottomSheetContent extends StatelessWidget {
  _BottomSheetContent();

  final indices = List<int>.generate(100, (index) => index).toList();

  @override
  Widget build(BuildContext context) => ListView(
    children: [
      for (final i in indices)
        ListTile(
          title: Text('Item $i'),
          tileColor: getMaterialColor(Colors.amber, i),
        ),
    ],
  );
}
