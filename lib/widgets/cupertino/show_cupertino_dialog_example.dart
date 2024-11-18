import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: _MyStatelessWidget()));

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: IconButton(
            onPressed: () async => showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Title'),
                content: const Text('Content'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('🍎'),
                  ),
                  CupertinoDialogAction(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('🍊'),
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.flutter_dash),
          ),
        ),
      );
}
