import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
import 'package:flutter/foundation.dart';

Future<bool> convertAudio({
  required String inputAudioPath,
  required String outputAudioPath,
}) async {
  // -y is to overwrite an output file if it already exists.
  final session = await FFmpegKit.execute(
    '-y -i $inputAudioPath $outputAudioPath',
  );
  final returnCode = await session.getReturnCode();
  return ReturnCode.isSuccess(returnCode);
}

void main() async {
  // Don't omit a filename extension, because ffmpeg uses it to detect the file format.
  const m4aPath = '/aaa/bbb.m4a';
  const mp3Path = '/ccc/ddd.mp3';
  final success = await convertAudio(
    inputAudioPath: m4aPath,
    outputAudioPath: mp3Path,
  );
  debugPrint('Success: $success');
}
