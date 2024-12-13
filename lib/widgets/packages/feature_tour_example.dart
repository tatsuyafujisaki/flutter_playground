import 'dart:async';

import 'package:features_tour/features_tour.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: SafeArea(child: App()),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final tourController = FeaturesTourController('App');

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeaturesTour(
              controller: tourController,
              index: 0,
              introduce: const Text(
                'This is TextButton 1\nWith enableAnimation = false',
              ),
              nextConfig: NextConfig(
                child: (onPressed) => ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Modified Next'),
                ),
              ),
              childConfig: ChildConfig(
                enableAnimation: false,
              ),
              child: TextButton(
                onPressed: () {},
                child: const Text('TextButton 1'),
              ),
            ),
            Align(
              child: FeaturesTour(
                controller: tourController,
                index: 1,
                introduce: const Text('This is TextButton 2'),
                child: TextButton(
                  onPressed: () {},
                  child: const Text('TextButton 2'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FeaturesTour(
                controller: tourController,
                index: 2,
                introduce: const Text('This is TextButton 3'),
                child: TextButton(
                  onPressed: () {},
                  child: const Text('TextButton 3'),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: FeaturesTour(
                  controller: tourController,
                  index: 3,
                  introduce: const Text(
                    'Go to the Second Page (A more complicated tour)',
                  ),
                  onPressed: () {},
                  doneConfig: DoneConfig(text: 'Second Page'),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Second Page'),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
