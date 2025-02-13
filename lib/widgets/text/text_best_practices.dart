import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: SafeArea(child: Scaffold(body: _MyStatelessWidget()))),
);

/// Note of the Text widget:
/// - The [Text.softWrap] is true.
/// - If [TextOverflow.ellipsis] is NOT set, the default [Text.maxLines] is
///   infinite.
/// - If [TextOverflow.ellipsis] is set, the default [Text.maxLines] is 1.
class _MyStatelessWidget extends StatelessWidget {
  final data = '⭐' * 100;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      const Text('''↓Use the following if you want to display all the text.'''),
      Text(data),
      const Text(
        '''↓Use the following if you want to ellipsize text on a single line.''',
      ),
      Text(data, overflow: TextOverflow.ellipsis),
      const Text(
        '''↓Use the following if you want to ellipsize text on `maxLines` lines.''',
      ),
      Text(data, overflow: TextOverflow.ellipsis, maxLines: 2),
    ],
  );
}
