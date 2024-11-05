import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_playground/packages/io/join_example.dart';

Future<String?> saveBinaryFileToExternalStorageDirectory(
  List<int> bytes, [
  String filename = 'deleteme',
]) async {
  final path = await joinExternalStorageDirectory(filename);
  if (path == null) {
    return null;
  }
  File(path).writeAsBytesSync(bytes, mode: FileMode.writeOnly);
  return _getDeviceFileExplorerFriendlyExternalStorageDirectory(path);
}

Future<String?> saveTextFileToExternalStorageDirectory(
  String contents, [
  String filename = 'deleteme.txt',
]) async {
  final path = await joinExternalStorageDirectory(filename);
  if (path == null) {
    return null;
  }
  File(path).writeAsStringSync(contents, mode: FileMode.writeOnly);
  return _getDeviceFileExplorerFriendlyExternalStorageDirectory(path);
}

void showHowtoPullSavedFile(String path) =>
    debugPrint('👉 adb pull $path ~/Desktop');

String _getDeviceFileExplorerFriendlyExternalStorageDirectory(
  String externalStorageDirectoryPath,
) =>
    externalStorageDirectoryPath
        .replaceFirst('/data/user/0', '/data/data')
        .replaceFirst('/storage/emulated/0', '/sdcard');
