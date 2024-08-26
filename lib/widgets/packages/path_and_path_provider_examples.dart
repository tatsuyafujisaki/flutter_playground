import 'dart:io';
import 'dart:typed_data';

// > The path library was designed to be imported with a prefix,
// > though you don't have to if you don't want to:
// https://pub.dev/documentation/path/
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

bool exist(String path) => File(path).existsSync();

String replaceExtension(String path, String extension) =>
    p.setExtension(path, extension.startsWith('.') ? extension : '.$extension');

Future<String> joinTemporaryDirectory(String relativePath) async => p.join(
      (await getTemporaryDirectory()).path,
      relativePath,
    );

class MyFile {
  MyFile(this.filenameWithoutExtension);
  String filenameWithoutExtension = '';

  String get mp3Filename => _getFilename('.mp3');
  String get m4aFilename => _getFilename('.m4a');

  Future<String> get m4aFilePath async => _joinTemporaryDirectory(m4aFilename);
  Future<String> get mp3FilePath async => _joinTemporaryDirectory(mp3Filename);

  Future<Uint8List> readMp3() async => _readFile(await mp3FilePath);
  Future<Uint8List> readM4a() async => _readFile(await m4aFilePath);

  String _getFilename(String extension) =>
      p.setExtension(filenameWithoutExtension, extension);

  Future<String> _joinTemporaryDirectory(String relativePath) async => p.join(
        (await getTemporaryDirectory()).path,
        relativePath,
      );

  Future<Uint8List> _readFile(String filepath) async =>
      File(filepath).readAsBytes();
}
