import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

@Preview()
Widget preview() => const _MyStatelessWidget();

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    initialChildSize: 0.7,
    builder: (context, scrollController) => ColoredBox(
      color: Colors.cyan,
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              controller: scrollController,
              itemCount: 25,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  'Item $index',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
