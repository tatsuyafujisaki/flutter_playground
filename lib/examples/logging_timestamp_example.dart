import 'dart:io';

import 'package:flutter/foundation.dart';
import '../packages/io/directories.dart';

Future<String> get _pauseTimestampFilePath =>
    joinTemporaryDirectory('pause_timestamp.txt');
Future<String> get _detachTimestampFilePath =>
    joinTemporaryDirectory('detach_timestamp.txt');

Future<DateTime?> getPauseTimestamp() async {
  final filePath = await _pauseTimestampFilePath;
  return _readTimestamp(filePath);
}

Future<DateTime?> getDetachTimestamp() async {
  final filePath = await _detachTimestampFilePath;
  return _readTimestamp(filePath);
}

Future<void> logPauseTimestamp() async =>
    _writeTimestamp(await _pauseTimestampFilePath);
Future<void> logDetachTimestamp() async =>
    _writeTimestamp(await _detachTimestampFilePath);

DateTime? _readTimestamp(String filePath) {
  try {
    final file = File(filePath);
    return DateTime.fromMillisecondsSinceEpoch(
      int.parse(file.readAsStringSync()),
    );
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
  return null;
}

void _writeTimestamp(String filePath) {
  try {
    File(
      filePath,
    ).writeAsStringSync(DateTime.now().millisecondsSinceEpoch.toString());
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
}
