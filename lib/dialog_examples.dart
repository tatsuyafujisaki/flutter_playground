import 'package:flutter/cupertino.dart';

Future<T?> showCupertinoDialogExample<T>(BuildContext context) =>
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Title'),
        content: const Text('Content'),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
