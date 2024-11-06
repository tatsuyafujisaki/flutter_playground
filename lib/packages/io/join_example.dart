import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<String> get applicationDocumentsDirectory async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<String> get temporaryDirectory async {
  final directory = await getTemporaryDirectory();
  return directory.path;
}

Future<String?> get externalStorageDirectory async {
  final directory = await getExternalStorageDirectory();
  return directory?.path;
}

Future<String> createTemporaryFile({String extension = ''}) async {
  final directory = await getTemporaryDirectory();
  return p.join(
    directory.path,
    p.setExtension(
      'delete-me-${DateTime.now().microsecondsSinceEpoch}',
      extension,
    ),
  );
}

Future<String> joinApplicationDocumentsDirectory(String relativePath) async =>
    p.join(await applicationDocumentsDirectory, relativePath);

Future<String?> joinExternalStorageDirectory(String relativePath) async {
  final directory = await externalStorageDirectory;
  return directory == null ? null : p.join(directory, relativePath);
}

Future<String> joinTemporaryDirectory(String relativePath) async =>
    p.join(await temporaryDirectory, relativePath);
