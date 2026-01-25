import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: RfwExample())));
}

class RfwExample extends StatefulWidget {
  const RfwExample({super.key});

  @override
  State<RfwExample> createState() => _RfwExampleState();
}

class _RfwExampleState extends State<RfwExample> {
  final _runtime = Runtime();
  final _data = DynamicContent();
  int _count = 0;

  static const _main = LibraryName(['main']);
  static const _coreWidgets = LibraryName(['core', 'widgets']);
  static const _coreMaterial = LibraryName(['core', 'material']);

  static const _rfwtxt = '''
    import core.widgets;
    import core.material;

    widget root = Scaffold(
      appBar: AppBar(
        title: Text(text: "RFW Counter"),
        backgroundColor: 0xFF6200EE,
        foregroundColor: 0xFFFFFFFF,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: "center",
          children: [
            Text(
              text: "Current Count",
              style: { fontSize: 16, color: 0xFF757575 },
            ),
            Text(
              text: data.count,
              style: { fontSize: 64, fontWeight: "bold", color: 0xFF6200EE },
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: event "increment" { },
              style: {
                backgroundColor: 0xFF6200EE,
                foregroundColor: 0xFFFFFFFF,
                padding: { left: 32, right: 32, top: 16, bottom: 16 },
              },
              child: Text(text: "Increment"),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: event "reset" { },
              child: Text(text: "Reset Counter"),
            ),
          ],
        ),
      ),
    );
  ''';

  @override
  void initState() {
    super.initState();
    _runtime
      ..update(_coreWidgets, createCoreWidgets())
      ..update(_coreMaterial, createMaterialWidgets());
    unawaited(_loadLibrary());

    _updateData();
  }

  @override
  Widget build(BuildContext context) => RemoteWidget(
    runtime: _runtime,
    data: _data,
    widget: const FullyQualifiedWidgetName(_main, 'root'),
    onEvent: (name, arguments) {
      setState(() {
        switch (name) {
          case 'increment':
            _count++;
          case 'reset':
            _count = 0;
        }
        _updateData();
      });
    },
  );

  Future<void> _loadLibrary() async {
    try {
      final byteData = await rootBundle.load('assets/input.rfw');
      final bytes = byteData.buffer.asUint8List();
      _runtime.update(_main, decodeLibraryBlob(bytes));
    } on Exception catch (exception, stackTrace) {
      developer.log('', error: exception, stackTrace: stackTrace);
      _runtime.update(_main, parseLibraryFile(_rfwtxt));
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _updateData() {
    _data.update('count', _count.toString());
  }
}
