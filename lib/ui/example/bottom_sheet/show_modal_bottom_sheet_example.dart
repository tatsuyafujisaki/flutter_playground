import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

@Preview()
Widget preview() => const _MyStatelessWidget();

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: IconButton(
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          builder: (_) => const _BottomSheetContent(),
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
  const _BottomSheetContent();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.close),
      ),
      title: const Text('My title'),
    ),
    body: const Center(child: FlutterLogo()),
  );
}
