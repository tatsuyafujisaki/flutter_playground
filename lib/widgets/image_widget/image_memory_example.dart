import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(
      _MyStatelessWidget(),
    );

class _MyStatelessWidget extends StatelessWidget {
  final imageBytes = downloadImage(
    'https://media1.tenor.com/m/NVP2kRD7CHsAAAAC/dancing-dog.gif',
  );

  @override
  Widget build(BuildContext context) => FutureBuilder<Uint8List>(
        future: imageBytes,
        builder: (_, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? Image.memory(snapshot.data!)
                : const CircularProgressIndicator(),
      );
}

Future<Uint8List> downloadImage(String url) async {
  final byteData = await NetworkAssetBundle(Uri.parse(url)).load('');
  return byteData.buffer.asUint8List();
}
