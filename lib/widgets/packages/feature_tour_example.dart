import 'dart:async';

import 'package:features_tour/features_tour.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: _MyStatefulWidget(),
    ),
  );
}

class _MyStatefulWidget extends StatefulWidget {
  const _MyStatefulWidget();

  @override
  State<_MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  final tourController = FeaturesTourController('');

  @override
  void initState() {
    super.initState();
    unawaited(
      tourController.start(
        context,
        force: true,
        predialogConfig: PredialogConfig(enabled: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < 3; i++)
                createFeaturesTour(
                  index: i.toDouble(),
                  introduce: createIntroduce('Explanation!'),
                  child: Icon(Icons.flutter_dash),
                ),
            ],
          ),
        ),
      );

  FeaturesTour createFeaturesTour({
    required double index,
    required Widget introduce,
    required Widget child,
  }) =>
      FeaturesTour(
        controller: tourController,
        index: index,
        introduce: introduce,
        // Replaces the default Next button with an empty widget.
        nextConfig: NextConfig(
          child: (_) => SizedBox.shrink(),
        ),
        // Replaces the default Skip button with an empty widget.
        skipConfig: SkipConfig(
          child: (_) => SizedBox.shrink(),
        ),
        // Replaces the default Done button with an empty widget.
        doneConfig: DoneConfig(
          child: (_) => SizedBox.shrink(),
        ),
        child: child,
      );

  Widget createIntroduce(String data) => Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_circle_right, color: Colors.black),
          ],
        ),
      );
}
