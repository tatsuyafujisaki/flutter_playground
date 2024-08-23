import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(
      const MaterialApp(
        home: Scaffold(
          body: _SoundWidget(audioFilePath: 'sample.m4a'),
          backgroundColor: Colors.white,
        ),
      ),
    );

class _SoundWidget extends StatefulWidget {
  const _SoundWidget({
    required this.audioFilePath,
  });

  final String audioFilePath;

  @override
  State<_SoundWidget> createState() => _SoundWidgetState();
}

class _SoundWidgetState extends State<_SoundWidget> {
  final recorder = FlutterSoundRecorder();
  final player = FlutterSoundPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        // You have to add the following to AndroidManifest.xml
        // <uses-permission android:name="android.permission.RECORD_AUDIO" />
        // https://developer.android.com/reference/android/Manifest.permission#RECORD_AUDIO
        // Otherwise, the following "request().isGranted" will return false
        // without displaying a runtime permission prompt.
        if (!await Permission.microphone.request().isGranted) {
          throw RecordingPermissionException(
            'Microphone permission not granted',
          );
        }
        await recorder.openRecorder();
        await player.openPlayer();
      },
    );
  }

  @override
  void dispose() {
    Future.delayed(
      Duration.zero,
      () async {
        await recorder.closeRecorder();
        await player.closePlayer();
      },
    );
    super.dispose();
  }

  Future<void> toggleRecorder() async {
    if (recorder.isRecording) {
      await recorder.stopRecorder();
    } else {
      await recorder.startRecorder(
        codec: Codec.aacMP4,
        toFile: widget.audioFilePath,
      );
    }
    setState(() {});
  }

  Future<void> togglePlayer() async {
    if (player.isPlaying) {
      await player.stopPlayer();
    } else {
      await player.startPlayer(
        fromURI: widget.audioFilePath,
        whenFinished: () => setState(() {}),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: player.isPlaying ? null : toggleRecorder,
              child: Text(recorder.isRecording ? 'Stop' : 'Record'),
            ),
            ElevatedButton(
              onPressed: recorder.isRecording ? null : togglePlayer,
              child: Text(player.isPlaying ? 'Stop' : 'Play'),
            ),
          ],
        ),
      );
}
