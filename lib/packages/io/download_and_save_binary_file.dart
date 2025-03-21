import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import 'download_file_example.dart';
import 'save_file_example.dart';

void main() => runApp(const _MyStatelessWidget());

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final path = await downloadAndSaveBinaryFile(
        'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
      );
      if (path != null) {
        showHowtoPullSavedFile(path);
      }
    });
    return const FlutterLogo();
  }
}

Future<String?> downloadAndSaveBinaryFile(String url) async {
  final bytes = await downloadBinaryFile(url);
  return saveBinaryFileToExternalStorageDirectory(bytes, p.basename(url));
}
