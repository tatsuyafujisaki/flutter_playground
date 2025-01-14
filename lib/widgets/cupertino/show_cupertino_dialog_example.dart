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
            final result = await showCupertinoDialog<String>(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Title!'),
                content: const Text('Content!'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () => Navigator.pop<String>(
                      context,
                      'Default action is chosen!',
                    ),
                    isDefaultAction: true,
                    child: const Text('I am default!'),
                  ),
                  CupertinoDialogAction(
                    onPressed: () => Navigator.pop<String>(
                      context,
                      'Destructive action is chosen!',
                    ),
                    isDestructiveAction: true,
                    child: const Text('I am destructive, so my color is red!'),
                  ),
                ],
              ),
            );
            debugPrint(result);
          },
          icon: const Icon(Icons.flutter_dash),
        ),
      );
}
