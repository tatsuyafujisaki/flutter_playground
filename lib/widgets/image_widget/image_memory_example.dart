import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/http_example.dart';

void main() => runApp(
      _MyStatelessWidget(),
    );

class _MyStatelessWidget extends StatelessWidget {
  final imageBytes = downloadBinaryFile(
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
