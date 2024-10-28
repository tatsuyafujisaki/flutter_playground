import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(
      MaterialApp(
        home: _MyStatefulWidget(),
      ),
    );

class _MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  late VideoPlayerController _videoPlayerController;

  Future<bool> get _initialized async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
    return true;
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.contentUri(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    )..addListener(
        () {
          final value = _videoPlayerController.value;
          debugPrint('👀isBuffering: ${value.isBuffering}');
          debugPrint('👀isCompleted: ${value.isCompleted}');
          debugPrint('👀isInitialized: ${value.isInitialized}');
          debugPrint('👀isLooping: ${value.isLooping}');
          debugPrint('👀isPlaying: ${value.isPlaying}');
        },
      );
  }

  @override
  Widget build(BuildContext context) => Center(
        child: FutureBuilder<bool>(
          future: _initialized,
          builder: (context, snapshot) => snapshot.data ?? false
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                )
              : VideoProgressIndicator(
                  _videoPlayerController,
                  allowScrubbing: true,
                ),
        ),
      );

  @override
  void dispose() {
    unawaited(_videoPlayerController.dispose());
    super.dispose();
  }
}
