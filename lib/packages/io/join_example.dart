import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<String> joinApplicationDocumentsDirectory(String relativePath) async {
  final directory = await getApplicationDocumentsDirectory();
  return p.join(directory.path, relativePath);
}

Future<String?> joinExternalStorageDirectory(String relativePath) async {
  final directory = await getExternalStorageDirectory();
  return directory == null ? null : p.join(directory.path, relativePath);
}

Future<String> joinTemporaryDirectory(String relativePath) async => p.join(
      (await getTemporaryDirectory()).path,
      relativePath,
    );
