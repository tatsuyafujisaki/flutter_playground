import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: SafeArea(
          child: Scaffold(
            body: _MyStatelessWidget(),
          ),
        ),
      ),
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
          const Text('displayes all the text.'),
          Text(data),
          const Text(
            '''↓Truncates text if it does not fit on a single line because of `softWrap: false`.''',
          ),
          Text(data, softWrap: false),
          const Text(
            '''↓Truncates text if it does not fit on a single line because of `softWrap: false`. `maxLines: 2` is ignored.''',
          ),
          Text(data, softWrap: false, maxLines: 2),
          const Text(
            '''↓Ellipsizes text if it does not fit on a single line because of `TextOverflow.ellipsis`.''',
          ),
          Text(data, overflow: TextOverflow.ellipsis),
          const Text(
            '''↓Ellipsizes text if it does not fit on a single line because of `TextOverflow.ellipsis` again.''',
          ),
          Text(data, softWrap: false, overflow: TextOverflow.ellipsis),
          const Text(
            '''↓Ellipsizes text if it does not fit on `maxLines` lines. `softWrap: false` is ignored.''',
          ),
          Text(
            data,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      );
}
