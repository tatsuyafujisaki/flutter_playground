import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/media/ffmpeg/ffmpeg.dart';
import 'package:flutter_playground/widgets/future_builder_and_stream_builder/future_builder/create_non_void_future_builder.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      body: SafeArea(child: _MyStatelessWidget()),
      backgroundColor: Colors.white,
    ),
  ),
);

class _MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => createNonVoidFutureBuilder(
    // ignore: discarded_futures
    future: _createThumbnail(
      'https://cdn.pixabay.com/video/2020/04/08/35427-407130886_large.mp4',
    ),
    onData:
        (thumbnailPath) =>
            thumbnailPath != null
                ? GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    debugPrint('👀The thumnail is tapped.');
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.file(File(thumbnailPath)),
                      const Icon(
                        Icons.play_circle,
                        size: 100,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
                : const Icon(Icons.broken_image),
  );
}

Future<String?> _createThumbnail(String videoPath) async {
  Future<bool> createThumbnail({
    required String inputVideoPath,
    required String outputThumbnailPath,
  }) async => ffmpeg(
    '-y -i $inputVideoPath -ss 00:00:01 -frames:v 1 $outputThumbnailPath',
  );
  final directory = await getTemporaryDirectory();
  final thumbnailPath = p.join(directory.path, 'thumbnail.jpg');
  final success = await createThumbnail(
    inputVideoPath: videoPath,
    outputThumbnailPath: thumbnailPath,
  );
  return success ? thumbnailPath : null;
}
