import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MaterialApp(home: _MyStatefulWidget()));

class _MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  final _controller = VideoPlayerController.networkUrl(
    Uri.parse(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    ),
  );
  final _initialized = Completer<void>();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final value = _controller.value;
      debugPrint('📹isBuffering: ${value.isBuffering}');
      debugPrint('📹isCompleted: ${value.isCompleted}');
      debugPrint('📹isInitialized: ${value.isInitialized}');
      debugPrint('📹isLooping: ${value.isLooping}');
      debugPrint('📹isPlaying: ${value.isPlaying}');
      debugPrint('📹position: ${value.position}');
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.initialize();
      await _controller.setLooping(true);
      await _controller.play();
      setState(() {}); // changes the FAB icon from "play_arrow" to "pause".
      _initialized.complete();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: FutureBuilder<void>(
        future: _initialized.future,
        builder:
            (context, snapshot) => Center(
              child:
                  snapshot.connectionState == ConnectionState.done
                      ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                      : const CircularProgressIndicator(),
            ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      onPressed: () {
        setState(() {
          unawaited(
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play(),
          );
        });
      },
    ),
    backgroundColor: Colors.white,
  );

  @override
  void dispose() {
    unawaited(_controller.dispose());
    super.dispose();
  }
}
