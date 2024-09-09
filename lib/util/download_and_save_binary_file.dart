import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<void> downloadAndSaveBinaryFile(String url) async {
  try {
    final uri = Uri.parse(url);
    final bytes = await _downloadBinaryFile(uri);
    final path = await _saveBinaryFile(bytes, p.basename(uri.path));
    debugPrint('👀adb pull $path ~/Desktop');
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
}

Future<Uint8List> _downloadBinaryFile(Uri uri) async {
  bool isSuccessful(int statusCode) => 200 <= statusCode && statusCode <= 299;

  final response = await http.get(uri);
  if (isSuccessful(response.statusCode)) {
    return response.bodyBytes;
  }
  throw Exception('Status code: ${response.statusCode}. URL: ${uri.path}');
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
