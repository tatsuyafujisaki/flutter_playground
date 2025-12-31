import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(
  ProviderScope(
    child: Image.network('https://media1.tenor.com/m/NVP2kRD7CHsAAAAC'),
  ),
);
