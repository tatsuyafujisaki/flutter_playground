import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/io/download_and_save_binary_file.dart';
import 'package:flutter_playground/packages/io/save_file_example.dart';
import 'package:flutter_playground/packages/media/ffmpeg/ffmpeg.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const _MyStatelessWidget());

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Don't omit a filename extension,
      // because ffmpeg uses it to detect the file format.
      final inputPath = await downloadAndSaveBinaryFile(
        'https://filesamples.com/samples/audio/m4a/Symphony%20No.6%20(1st%20movement).m4a',
      );
      if (inputPath == null) {
        return;
      }
      final outputPath = p.setExtension(inputPath, '.mp3');
      final success = await ffmpeg('-y -i $inputPath $outputPath');
      if (success) {
        showHowtoPullSavedFile(outputPath);
      }
      File(inputPath).deleteSync();
    });
    return const FlutterLogo();
  }
}
