import 'dart:io';

import 'package:flutter/foundation.dart';
// > The path library was designed to be imported with a prefix,
// > though you don't have to if you don't want to:
// https://pub.dev/documentation/path/
import 'package:path/path.dart' as p;

bool exist(String path) => File(path).existsSync();

String replaceExtension(String path, String extension) =>
    p.setExtension(path, extension.startsWith('.') ? extension : '.$extension');

void deleteIfExists(String path) {
  final file = File(path);
  if (file.existsSync()) {
    try {
      file.deleteSync(recursive: true);
    } on FileSystemException catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }
}
