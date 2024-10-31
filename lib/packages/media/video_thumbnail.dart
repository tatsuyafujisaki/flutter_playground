import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/future_builder_and_stream_builder/future_builder/create_non_void_future_builder.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

void main() => runApp(
      MaterialApp(
        home: SafeArea(child: _MyStatelessWidget()),
      ),
    );

class _MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final future = VideoThumbnail.thumbnailData(
      video: 'https://cdn.pixabay.com/video/2024/07/27/223461_large.mp4',
      imageFormat: ImageFormat.JPEG,
    );
    return createNonVoidFutureBuilder(
      future: future,
      onData: (bytes) =>
          bytes != null ? Image.memory(bytes) : const SizedBox.shrink(),
    );
  }
}
