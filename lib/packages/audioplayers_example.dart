import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/util/duration_utils.dart';

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
          ..onPositionChanged.map(formatInMSs).distinct().listen(
                (mSs) => debugPrint('👀Position changed: $mSs'),
              )
          ..onPlayerStateChanged.listen(
            (playerState) => debugPrint('👀Player state changed: $playerState'),
          )
          ..onSeekComplete.listen(
            (_) => debugPrint('👀Seek complete'),
          )
          ..onPlayerComplete.listen(
            (_) => debugPrint('👀Player complete'),
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
