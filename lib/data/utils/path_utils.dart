import 'dart:developer' as developer;
import 'dart:io';

// > Though the path library was designed to be imported with a prefix,
// > you don't have to if you don't want to.
// https://pub.dev/packages/path
import 'package:path/path.dart' as p;

bool exists(String path) {
  try {
    return File(path).existsSync();
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
    return false;
  }
}

String replaceExtension(String path, String extension) => p.setExtension(
  path,
  extension.isEmpty || extension.startsWith('.') ? extension : '.$extension',
);

void deleteIfExists(String path) {
  final file = File(path);
  try {
    if (!file.existsSync()) {
      return;
    }
    file.deleteSync(recursive: true);
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
  }
}
