import 'dart:io';

import 'package:ffmpeg_kit_flutter_full/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/io/download_and_save_binary_file.dart';
import 'package:flutter_playground/packages/io/join_example.dart';
import 'package:flutter_playground/packages/io/save_file_example.dart';
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
        final success = await _trimVideo(
          inputPath: mp4Path,
          outputPath: trimmedMp4Path,
          secondsToTrimAt: 3,
        );
        if (success) {
          showHowtoPullSavedFile(trimmedMp4Path);
        }
        File(mp4Path).deleteSync();
      },
    );
    return const FlutterLogo();
  }
}

/// Unlike the command line version of FFmpeg,
/// FFmpeg in the ffmpeg_kit_flutter_audio package does not support URLs
/// as input or output.
Future<bool> _trimVideo({
  required String inputPath,
  required String outputPath,
  required int secondsToTrimAt,
}) async {
  final session = await FFmpegKit.execute(
    '-y -t $secondsToTrimAt -i $inputPath $outputPath',
  );

  final output = await session.getOutput() ?? '';
  if (output.isNotEmpty) {
    debugPrint('FFmpeg output: $output');
  }

  final logs = await session.getLogs();
  for (final log in logs) {
    debugPrint('FFmpeg logMessage: ${log.getMessage()}');
  }

  final failStackTrace = await session.getFailStackTrace() ?? '';
  if (failStackTrace.isNotEmpty) {
    debugPrint('FFmpeg failStackTrace: $failStackTrace');
  }

  final returnCode = await session.getReturnCode();
  return ReturnCode.isSuccess(returnCode);
}
