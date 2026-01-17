import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(
  const ProviderScope(
    child: MaterialApp(home: Scaffold(body: _MyStatelessWidget())),
  ),
);

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => Center(
    child: IconButton(
      onPressed: () async {
        final result = await showCupertinoModalPopup<String>(
          context: context,
          builder: (context) => CupertinoActionSheet(
            title: const Text('Title'),
            message: const Text('Message'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context, '🍎'),
                child: const Text(
                  'I am neither a destructive nor default action.',
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context, '🍏'),
                isDefaultAction: true,
                child: const Text('I am a default action.'),
              ),
              CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context, '🍊'),
                isDestructiveAction: true,
                child: const Text('I am a destructive action.'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('cancel'),
            ),
          ),
        );
        developer.log('👀showCupertinoModalPopup returns $result');
      },
      icon: const Icon(Icons.flutter_dash),
    ),
  );
}
