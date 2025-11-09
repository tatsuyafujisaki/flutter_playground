import 'dart:async';

import 'package:flutter/foundation.dart';

void main() async {
  final streamController =
      StreamController<String>.broadcast()
        ..stream.listen((event) => debugPrint('Listener 1: $event'))
        ..stream.listen((event) => debugPrint('Listener 2: $event'))
        ..add('🍎')
        ..add('🍊');

  await streamController.close();
}
