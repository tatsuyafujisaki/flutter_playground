/// Unlike the command line version of FFmpeg,
/// FFmpeg in the ffmpeg_kit_flutter_audio package does not support URLs
/// as input or output.
Future<bool> ffmpeg(String command) async {
  // final session = await FFmpegKit.execute(command);

  // final output = await session.getOutput() ?? '';
  // if (output.isNotEmpty) {
  //   debugPrint('FFmpeg output: $output');
  // }

  // final logs = await session.getLogs();
  // for (final log in logs) {
  //   debugPrint('FFmpeg logMessage: ${log.getMessage()}');
  // }

  // final failStackTrace = await session.getFailStackTrace() ?? '';
  // if (failStackTrace.isNotEmpty) {
  //   debugPrint('FFmpeg failStackTrace: $failStackTrace');
  // }

  // final returnCode = await session.getReturnCode();
  // return ReturnCode.isSuccess(returnCode);
  return false;
}
