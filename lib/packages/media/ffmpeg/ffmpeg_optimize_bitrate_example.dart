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
      final inputPath = await downloadAndSaveBinaryFile(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      );
      if (inputPath == null) {
        return;
      }
      final outputPath = await createTemporaryFilePath(
        directory: (await externalStorageDirectory)!,
        extension: p.extension(inputPath),
      );
      debugPrint('⏱️[FFmpeg starts]${DateTime.now()}');
      final success = await ffmpeg(
        '-y -i $inputPath -vf fps=10,scale=-1:144 -t 300 $outputPath',
      );
      debugPrint('⏱️[FFmpeg ends]${DateTime.now()}');
      if (success) {
        showHowtoPullSavedFile(inputPath);
        showHowtoPullSavedFile(outputPath);
      }
    });
    return const FlutterLogo();
  }
}
