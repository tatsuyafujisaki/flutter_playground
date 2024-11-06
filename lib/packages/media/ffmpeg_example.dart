import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/io/download_and_save_binary_file.dart';
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
        final inputPath = await downloadAndSaveBinaryFile(
          'https://filesamples.com/samples/audio/m4a/Symphony%20No.6%20(1st%20movement).m4a',
        );
        if (inputPath == null) {
          return;
        }
        final outputPath = p.setExtension(inputPath, '.mp3');
        final success = await ffmpeg(
          inputPath: inputPath,
          outputPath: outputPath,
        );
        if (success) {
          showHowtoPullSavedFile(outputPath);
        }
      },
    );
    return const FlutterLogo();
  }
}

/// Unlike the command line version of FFmpeg,
/// FFmpeg in the ffmpeg_kit_flutter_audio package does not support URLs as input or output.
Future<bool> ffmpeg({
  required String inputPath,
  required String outputPath,
}) async {
  // -y is to overwrite an output file if it already exists.
  final session = await FFmpegKit.execute(
    '-y -i $inputPath $outputPath',
  );

  final output = await session.getOutput();
  if (output != null && output.isNotEmpty) {
    debugPrint('FFmpeg output: $output');
  }

  final logs = await session.getLogs();
  for (final log in logs) {
    debugPrint('FFmpeg logMessage: ${log.getMessage()}');
  }

  final failStackTrace = await session.getFailStackTrace();
  if (failStackTrace != null && failStackTrace.isNotEmpty) {
    debugPrint('FFmpeg failStackTrace: $failStackTrace');
  }

  final returnCode = await session.getReturnCode();
  return ReturnCode.isSuccess(returnCode);
}
