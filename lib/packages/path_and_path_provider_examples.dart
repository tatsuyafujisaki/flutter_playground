import 'dart:io';

// > The path library was designed to be imported with a prefix,
// > though you don't have to if you don't want to:
// https://pub.dev/documentation/path/
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

String _converToPathInDeviceFileExplorer(String path) => path
    .replaceFirst('/data/user/0', '/data/data')
    .replaceFirst('/storage/emulated/0', '/sdcard');

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

Future<String> saveBytes(
  List<int> bytes, [
  String filename = 'deleteme.bin',
]) async {
  final path = await joinExternalStorageDirectory(filename);
  if (path == null) {
    return '';
  }
  File(path).writeAsBytesSync(bytes, mode: FileMode.writeOnly);
  return _converToPathInDeviceFileExplorer(path);
}

Future<String> saveString(
  String contents, [
  String filename = 'deleteme.txt',
]) async {
  final path = await joinExternalStorageDirectory(filename);
  if (path == null) {
    return '';
  }
  File(path).writeAsStringSync(contents, mode: FileMode.writeOnly);
  return _converToPathInDeviceFileExplorer(path);
}

void main() => runApp(
      const MaterialApp(
        home: _MyStatelessWidget(),
      ),
    );

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        const contents = '🍎';
        final path = await saveString(contents);
        debugPrint('👀adb pull $path ~/Desktop');
      },
    );

    return const FlutterLogo();
  }
}
