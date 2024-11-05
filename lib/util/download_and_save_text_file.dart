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
      (_) async {
        final path = await _downloadAndSaveTextFile(
          'https://www.w3.org/robots.txt',
        );
        debugPrint('👀How to pull the saved file: adb pull $path ~/Desktop');
      },
    );
    return const FlutterLogo();
  }
}

Future<String> _downloadAndSaveTextFile(String url) async {
  var path = '';
  try {
    final uri = Uri.parse(url);
    final bytes = await downloadString(uri);
    path = await _saveTextFile(bytes, p.basename(uri.path));
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
  return path;
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
