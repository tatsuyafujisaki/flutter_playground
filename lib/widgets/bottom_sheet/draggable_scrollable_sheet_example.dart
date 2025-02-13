import 'package:flutter/material.dart';

void main() =>
    runApp(const MaterialApp(home: Scaffold(body: _MyStatefulWidget())));

class _MyStatefulWidget extends StatefulWidget {
  const _MyStatefulWidget();

  @override
  State<_MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    initialChildSize: 0.7,
    builder:
        (context, scrollController) => ColoredBox(
          color: Colors.cyan,
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder:
                      (context, index) => ListTile(
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
