import 'dart:io';

// > The path library was designed to be imported with a prefix,
// > though you don't have to if you don't want to:
// https://pub.dev/documentation/path/
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

bool exist(String path) => File(path).existsSync();

String replaceExtension(String path, String extension) =>
    p.setExtension(path, extension.startsWith('.') ? extension : '.$extension');

Future<String> joinApplicationDocumentsDirectory(String relativePath) async =>
    p.join(
      (await getApplicationDocumentsDirectory()).path,
      relativePath,
    );

Future<String> joinTemporaryDirectory(String relativePath) async => p.join(
      (await getTemporaryDirectory()).path,
      relativePath,
    );

Future<void> saveAsFile(String contents) async {
  final path = await joinTemporaryDirectory('deleteme.txt');

  debugPrint('👀path: $path');
  debugPrint(
    '👀path in the Device File Explorer: ${converToPathInDeviceFileExplorer(path)}}',
  );

  File(path).writeAsStringSync(contents);
}

String converToPathInDeviceFileExplorer(String path) =>
    path.replaceFirst('/data/user/0', '/data/data');
