import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(
        home: Scaffold(
          body: _MyStatelessWidget(),
        ),
      ),
    );

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => Center(
        child: IconButton(
          onPressed: () async {
            final fruit = await showCupertinoDialog<String>(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Title'),
                content: const Text('Content'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () => Navigator.pop<String>(context, '🍎'),
                    child: const Text('🍎'),
                  ),
                  CupertinoDialogAction(
                    onPressed: () => Navigator.pop<String>(context, '🍊'),
                    child: const Text('🍊'),
                  ),
                ],
              ),
            );
            debugPrint(fruit);
          },
          icon: const Icon(Icons.flutter_dash),
        ),
      );
}
