import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(
        home: Scaffold(
          body: _MyStatefulsWidget(),
          backgroundColor: Colors.white,
        ),
      ),
    );

class _MyStatefulsWidget extends StatefulWidget {
  const _MyStatefulsWidget();

  @override
  State<_MyStatefulsWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulsWidget> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await configureAudioPlayer(
          player,
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/dash/ForBiggerFunAudio.mp4',
        );
        await player.resume();
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) => Center(
        child: IconButton(
          icon: Icon(
            player.state == PlayerState.playing
                ? Icons.pause
                : Icons.play_arrow,
          ),
          onPressed: () async {
            if (player.state == PlayerState.playing) {
              await player.pause();
            } else {
              await player.resume();
            }
            setState(() {});
          },
        ),
      );

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => player.dispose(),
    );

    super.dispose();
  }

  Future<void> configureAudioPlayer(AudioPlayer player, String url) async {
    player
      ..onDurationChanged.listen(
        (duration) => debugPrint('👀Duration changed: $duration'),
      )
      ..onPositionChanged
          .map(
            (duration) => Duration(
              minutes: duration.inMinutes,
              seconds: duration.inSeconds,
            ),
          )
          .distinct()
          .listen(
            (duration) => debugPrint(
              '👀Position changed: ${formatInMSs(duration)}',
            ),
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
    // > To reduce preparation latency, instead consider calling setSource
    // > beforehand and then resume separately.
    // https://pub.dev/documentation/audioplayers/latest/audioplayers/AudioPlayer/play.html
    await player.setSourceUrl(url);
  }

  String formatInMSs(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
