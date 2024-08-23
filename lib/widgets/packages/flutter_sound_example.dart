import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/packages/ffmpeg_example.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(
      const MaterialApp(
        home: Scaffold(
          body: _SoundWidget(),
          backgroundColor: Colors.white,
        ),
      ),
    );

class _SoundWidget extends StatefulWidget {
  const _SoundWidget();

  @override
  State<_SoundWidget> createState() => _SoundWidgetState();
}

class _SoundWidgetState extends State<_SoundWidget> {
  final String m4aFilename = 'sample.m4a';
  late String mp3FilePath;
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
      final m4aFilePath = await _joinTemporaryDirectory(m4aFilename);
      mp3FilePath = p.setExtension(m4aFilePath, '.mp3');
      await convertAudio(
        inputAudioPath: m4aFilePath,
        outputAudioPath: mp3FilePath,
      );
    } else {
      await recorder.startRecorder(
        codec: Codec.aacMP4,
        toFile: m4aFilename,
      );
    }
    setState(() {});
  }

  Future<void> togglePlayer() async {
    if (player.isPlaying) {
      await player.stopPlayer();
    } else {
      await player.startPlayer(
        fromURI: mp3FilePath,
        codec: Codec.mp3,
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

Future<String> _joinTemporaryDirectory(String relativePath) async =>
    p.join(
      (await getTemporaryDirectory()).path,
      relativePath,
    );
