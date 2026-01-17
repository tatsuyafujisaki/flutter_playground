import 'dart:developer' as developer;
import 'dart:io';

// > The path library was designed to be imported with a prefix,
// > though you don't have to if you don't want to:
// https://pub.dev/documentation/path/
import 'package:path/path.dart' as p;

bool exists(String path) => File(path).existsSync();

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
