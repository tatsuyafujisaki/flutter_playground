import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../../io/directories.dart';
import '../../io/download_and_save_binary_file.dart';
import '../../io/save_file_example.dart';
import '../../io/temporary_file.dart';
import 'ffmpeg.dart';

void main() => runApp(const _MyStatelessWidget());

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Don't omit a filename extension,
      // because ffmpeg uses it to detect the file format.
      final mp4Path = await downloadAndSaveBinaryFile(
        'https://cdn.pixabay.com/video/2020/04/08/35427-407130886_large.mp4',
      );
      if (mp4Path == null) {
        return;
      }
      final trimmedMp4Path = await createTemporaryFilePath(
        directory: (await externalStorageDirectory)!,
        extension: p.extension(mp4Path),
      );
      debugPrint('⏱️[FFmpeg starts] ${DateTime.now()}');
      final success = await ffmpeg('-y -i -t 3 $mp4Path $trimmedMp4Path');
      debugPrint('⏱️[FFmpeg ends] ${DateTime.now()}');
      if (success) {
        File(trimmedMp4Path).renameSync(mp4Path);
        showHowtoPullSavedFile(mp4Path);
      }
    });
    return const FlutterLogo();
  }
}
