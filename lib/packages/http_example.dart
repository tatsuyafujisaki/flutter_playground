import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}
