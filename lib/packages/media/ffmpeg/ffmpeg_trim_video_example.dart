import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/io/directories.dart';
import 'package:flutter_playground/packages/io/download_and_save_binary_file.dart';
import 'package:flutter_playground/packages/io/save_file_example.dart';
import 'package:flutter_playground/packages/io/temporary_file.dart';
import 'package:flutter_playground/packages/media/ffmpeg/ffmpeg.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const _MyStatelessWidget());

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        // Don't omit a filename extension,
        // because ffmpeg uses it to detect the file format.
        final mp4Path = await downloadAndSaveBinaryFile(
          'https://cdn.pixabay.com/video/2020/04/08/35427-407130886_large.mp4',
        );
        if (mp4Path == null) {
          return;
        }
        final trimmedMp4Path = await createTemporaryFile(
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
      },
    );
    return const FlutterLogo();
  }
}
