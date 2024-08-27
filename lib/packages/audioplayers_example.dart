import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      const _MyStatelessWidget(),
    );

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (callback) async {
        final player = AudioPlayer();
        await player.play(
          UrlSource(
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/dash/ForBiggerFunAudio.mp4',
          ),
        );
      },
    );

    return const FlutterLogo();
  }
}
