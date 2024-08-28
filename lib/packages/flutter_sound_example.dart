import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/ffmpeg_example.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(
      const MaterialApp(
        home: Scaffold(
          body: _MyStatefulWidget(),
          backgroundColor: Colors.white,
        ),
      ),
    );

class _MyStatefulWidget extends StatefulWidget {
  const _MyStatefulWidget();

  @override
  State<_MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  final _AudioFile m4aFile = _AudioFile('sample.m4a');
  final _AudioFile mp3File = _AudioFile('sample.mp3');

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
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                recorder.isRecording ? Icons.mic_off : Icons.mic,
              ),
              onPressed: player.isPlaying ? null : toggleRecorder,
            ),
            IconButton(
              icon: Icon(
                player.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: recorder.isRecording ? null : togglePlayer,
            ),
          ],
        ),
      );

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await recorder.closeRecorder();
        await player.closePlayer();
      },
    );
    super.dispose();
  }

  Future<void> toggleRecorder() async {
    if (recorder.isRecording) {
      await recorder.stopRecorder();
      await convertAudio(
        inputAudioPath: await m4aFile.filePath,
        outputAudioPath: await mp3File.filePath,
      );
    } else {
      await recorder.startRecorder(
        codec: Codec.aacMP4,
        toFile: m4aFile.filename,
      );
    }
    setState(() {});
  }

  Future<void> togglePlayer() async {
    if (player.isPlaying) {
      await player.stopPlayer();
    } else {
      await player.startPlayer(
        fromURI: mp3File.filename,
        codec: Codec.mp3,
        whenFinished: () => setState(() {}),
      );
    }
    setState(() {});
  }
}

class _AudioFile {
  _AudioFile(this.filename);
  String filename;

  String get filenameWithoutExtension => p.withoutExtension(filename);
  Future<String> get filePath async => _joinTemporaryDirectory(filename);
  Future<Uint8List> get bytes async => File(await filePath).readAsBytes();

  Future<void> delete() async => File(filename).delete();

  Future<String> _joinTemporaryDirectory(String relativePath) async => p.join(
        (await getTemporaryDirectory()).path,
        relativePath,
      );
}
