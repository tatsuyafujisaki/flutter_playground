import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
      _MyStatelessWidget(),
    );

class _MyStatelessWidget extends StatelessWidget {
  final imageBytes = _downloadImage(
    'https://media1.tenor.com/m/NVP2kRD7CHsAAAAC',
  );

  @override
  Widget build(BuildContext context) => FutureBuilder<Uint8List>(
        future: imageBytes,
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            debugPrintStack(stackTrace: snapshot.stackTrace);
            return const Icon(Icons.broken_image);
          }
          if (snapshot.hasData) {
            return Image.memory(snapshot.data!);
          }
          return const SizedBox.shrink();
        },
      );
}

Future<Uint8List> _downloadImage(String url) async {
  final response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}
