import 'dart:io';

// > The path library was designed to be imported with a prefix,
// > though you don't have to if you don't want to:
// https://pub.dev/documentation/path/
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

bool exist(String path) => File(path).existsSync();

String replaceExtension(String path, String extension) =>
    p.setExtension(path, extension.startsWith('.') ? extension : '.$extension');

Future<String> joinTemporaryDirectory(String relativePath) async =>
    p.join(
      (await getTemporaryDirectory()).path,
      relativePath,
    );
