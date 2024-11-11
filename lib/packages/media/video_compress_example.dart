import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/io/download_and_save_binary_file.dart';
import 'package:flutter_playground/packages/io/save_file_example.dart';
import 'package:video_compress/video_compress.dart';

void main() => runApp(
      const MaterialApp(
        home: _MyStatelessWidget(),
      ),
    );

class _MyStatelessWidget extends StatefulWidget {
  const _MyStatelessWidget();

  @override
  State<_MyStatelessWidget> createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<_MyStatelessWidget> {
  String? path;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        path = await downloadAndSaveBinaryFile(
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
        );
        if (path == null) {
          return;
        }
        setState(() {});
        if (!VideoCompress.isCompressing) {
          final mediaInfo = await VideoCompress.compressVideo(
            path!,
            deleteOrigin: true,
            duration: 5,
          );
          showHowtoPullSavedFile(mediaInfo?.path ?? '');
        }
      },
    );
    return FutureBuilder<Uint8List?>(
      future: path != null ? VideoCompress.getByteThumbnail(path!) : null,
      builder: (context, snapshot) => snapshot.hasData && snapshot.data != null
          ? Image.memory(snapshot.data!)
          : const CircularProgressIndicator(),
    );
  }
}
