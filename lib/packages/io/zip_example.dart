import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/io/download_and_save_binary_file.dart';
import 'package:flutter_playground/packages/io/save_file_example.dart';
import 'package:path/path.dart' as p;

void main() => runApp(
      const _MyStatelessWidget(),
    );

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final path = await downloadAndSaveBinaryFile(
          'https://cdn.pixabay.com/video/2023/11/28/191159-889246512_large.mp4',
        );
        if (path == null) {
          return;
        }
        final zipPath = await createZip(path);
        if (zipPath == null) {
          return;
        }
        showHowtoPullSavedFile(zipPath);
      },
    );
    return const FlutterLogo();
  }
}

Future<String?> createZip(String sourceFilePath) async {
  final bytes = File(sourceFilePath).readAsBytesSync();
  final archive = Archive()
    ..addFile(ArchiveFile(p.basename(sourceFilePath), bytes.length, bytes));

  final zipData = ZipEncoder().encode(archive, level: Deflate.BEST_COMPRESSION);
  if (zipData == null) {
    return null;
  }
  final zipPath = p.setExtension(sourceFilePath, '.zip');
  File(zipPath).writeAsBytesSync(zipData);
  return zipPath;
}
