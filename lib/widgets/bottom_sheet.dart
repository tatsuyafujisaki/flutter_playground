import 'package:flutter/material.dart';

Future<void> showModalBottomSheetExample<T>(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const Text('Title'),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text('Body'),
          ],
        ),
      ),
      useSafeArea: true,
    );
