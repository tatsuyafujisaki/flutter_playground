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
      (_) async {
        final player = AudioPlayer()
          ..onDurationChanged.listen(
            (duration) => debugPrint('👀Duration changed: $duration'),
          )
          ..onPositionChanged
              .map((duration) => (duration.inMinutes, duration.inSeconds))
              .distinct()
              .listen(
            (e) {
              final minutes = e.$1;
              final seconds = e.$2.toString().padLeft(2, '0');
              debugPrint('👀Position changed $minutes:$seconds');
            },
          )
          ..onPlayerStateChanged.listen(
            (playerState) => debugPrint('👀Player state changed: $playerState'),
          )
          ..onSeekComplete.listen(
            (event) => debugPrint('👀Seek complete'),
          )
          ..onPlayerComplete.listen(
            (event) => debugPrint('👀Player complete'),
          );
        await player.play(
          UrlSource(
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/dash/ForBiggerBlazesAudio.mp4',
          ),
        );
      },
    );

    return const FlutterLogo();
  }
}
