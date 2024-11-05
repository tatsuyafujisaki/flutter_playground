import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/io/download_file_example.dart';
import 'package:flutter_playground/packages/io/save_file_example.dart';
import 'package:path/path.dart' as p;

void main() => runApp(
      const _MyStatelessWidget(),
    );

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final path = await downloadAndSaveBinaryFile(
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
        );
        if (path != null) {
          showHowtoPullSavedFile(path);
        }
      },
    );
    return const FlutterLogo();
  }
}

Future<String?> downloadAndSaveBinaryFile(String url) async {
  String? path;
  try {
    final bytes = await downloadBinaryFile(url);
    path = await saveBinaryFileToExternalStorageDirectory(
      bytes,
      p.basename(url),
    );
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
  return path;
}
