import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../packages/io/download_file_example.dart';

void main() => runApp(ProviderScope(child: _MyStatelessWidget()));

class _MyStatelessWidget extends StatelessWidget {
  final imageBytes = downloadBinaryFile(
    'https://media1.tenor.com/m/NVP2kRD7CHsAAAAC',
  );

  @override
  Widget build(BuildContext context) => FutureBuilder<Uint8List>(
    future: imageBytes,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Image.memory(snapshot.data!);
      }
      if (snapshot.hasError) {
        developer.log(snapshot.error.toString());
        developer.log(snapshot.stackTrace.toString());
        return const Icon(Icons.broken_image);
      }
      return const CircularProgressIndicator();
    },
  );
}
