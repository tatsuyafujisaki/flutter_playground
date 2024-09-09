import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      (_) async => _downloadAndSaveTextFile('https://www.w3.org/robots2s.txt'),
    );
    return const FlutterLogo();
  }
}

Future<void> _downloadAndSaveTextFile(String url) async {
  try {
    final uri = Uri.parse(url);
    final bytes = await _downloadTextFile(uri);
    final path = await _saveTextFile(bytes, p.basename(uri.path));
    debugPrint('👀adb pull $path ~/Desktop');
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
}

Future<String> _downloadTextFile(Uri uri) async {
  bool isSuccessful(int statusCode) => 200 <= statusCode && statusCode <= 299;

  final response = await http.get(uri);
  if (isSuccessful(response.statusCode)) {
    return response.body;
  }
  throw Exception(
    'Status code: ${response.statusCode}\nReason phrase: ${response.reasonPhrase}\nURL: $uri',
  );
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
