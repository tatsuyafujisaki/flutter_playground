import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/io/download_file_example.dart';
import 'package:flutter_playground/packages/io/save_file_example.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const _MyStatelessWidget());

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final path = await _downloadAndSaveTextFile(
        'https://www.w3.org/robots.txt',
      );
      if (path != null) {
        showHowtoPullSavedFile(path);
      }
    });
    return const FlutterLogo();
  }
}

Future<String?> _downloadAndSaveTextFile(String url) async {
  final uri = Uri.parse(url);
  final bytes = await downloadTextFile(uri);
  return saveTextFileToExternalStorageDirectory(bytes, p.basename(uri.path));
}
