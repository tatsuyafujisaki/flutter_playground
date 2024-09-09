import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/http_example.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

void main() => runApp(
      const _MyStatelessWidget(),
    );

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => _downloadAndSaveTextFile('https://www.w3.org/robots.txt'),
    );
    return const FlutterLogo();
  }
}

Future<void> _downloadAndSaveTextFile(String url) async {
  try {
    final uri = Uri.parse(url);
    final bytes = await downloadString(uri);
    final path = await _saveTextFile(bytes, p.basename(uri.path));
    debugPrint('👀adb pull $path ~/Desktop');
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
}

Future<String> _saveTextFile(String contents, String filename) async {
  final directory = await getExternalStorageDirectory();
  if (directory == null) {
    throw Exception('Failed to get the external storage directory.');
  }
  final path = p.join(directory.path, filename);
  File(path).writeAsStringSync(contents, mode: FileMode.writeOnly);
  return path;
}
