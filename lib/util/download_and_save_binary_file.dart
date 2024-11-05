import 'dart:io';
import 'dart:typed_data';

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
      (_) async {
        final path = await downloadAndSaveBinaryFile(
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
        );
        debugPrint('👀How to pull the saved file: adb pull $path ~/Desktop');
      },
    );
    return const FlutterLogo();
  }
}

Future<String> downloadAndSaveBinaryFile(String url) async {
  var path = '';
  try {
    final uri = Uri.parse(url);
    final bytes = await _downloadBinaryFile(uri);
    path = await _saveBinaryFile(bytes, p.basename(uri.path));
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
  return path;
}

Future<Uint8List> _downloadBinaryFile(Uri uri) async {
  bool isSuccessful(int statusCode) => 200 <= statusCode && statusCode <= 299;

  final response = await http.get(uri);
  if (isSuccessful(response.statusCode)) {
    return response.bodyBytes;
  }
  throw Exception(
    'Status code: ${response.statusCode}\nReason phrase: ${response.reasonPhrase}\nURL: $uri',
  );
}

Future<String> _saveBinaryFile(List<int> bytes, String filename) async {
  final directory = await getExternalStorageDirectory();
  if (directory == null) {
    throw Exception('Failed to get the external storage directory.');
  }
  final path = p.join(directory.path, filename);
  File(path).writeAsBytesSync(bytes, mode: FileMode.writeOnly);
  return path;
}
