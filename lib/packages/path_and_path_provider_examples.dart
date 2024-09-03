import 'dart:io';

// > The path library was designed to be imported with a prefix,
// > though you don't have to if you don't want to:
// https://pub.dev/documentation/path/
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

String converToPathInDeviceFileExplorer(String path) => path
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

Future<void> saveAsFile(String contents) async {
  final path = await joinExternalStorageDirectory('deleteme.txt');
  if (path == null) {
    return;
  }

  File(path).writeAsStringSync(contents);
  debugPrint(
    '👀adb pull ${converToPathInDeviceFileExplorer(path)} ~/Desktop',
  );
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
        await saveAsFile(contents);
      },
    );

    return const FlutterLogo();
  }
}
