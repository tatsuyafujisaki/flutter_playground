import 'dart:io';
import 'package:path/path.dart' as p;

Future<String> readFileUnderCurrentDirectory(String filename) async =>
    File(p.join(Directory.current.path, filename)).readAsString();
