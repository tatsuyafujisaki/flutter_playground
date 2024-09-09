import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(
      MaterialApp(
        home: _MyStatelessWidget(),
      ),
    );

class _MyStatelessWidget extends StatelessWidget {
  final imageBytes = getBytesFromNetworkImage();

  @override
  Widget build(BuildContext context) => FutureBuilder<Uint8List>(
        future: imageBytes,
        builder: (_, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? Image.memory(snapshot.data!)
                : const CircularProgressIndicator(),
      );
}

Future<Uint8List> getBytesFromNetworkImage() async {
  const imageUrl =
      'https://media1.tenor.com/m/NVP2kRD7CHsAAAAC/dancing-dog.gif';
  final byteData = await NetworkAssetBundle(Uri.parse(imageUrl)).load('');
  return byteData.buffer.asUint8List();
}
