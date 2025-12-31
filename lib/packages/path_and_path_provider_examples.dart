import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'io/save_file_example.dart';

void main() =>
    runApp(const ProviderScope(child: MaterialApp(home: _MyStatelessWidget())));

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      const contents = '🍎';
      final path = await saveTextFileToExternalStorageDirectory(contents);
      if (path != null) {
        showHowtoPullSavedFile(path);
      }
    });

    return const FlutterLogo();
  }
}
