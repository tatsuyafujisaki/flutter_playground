import 'dart:developer' as developer;

import 'package:gal/gal.dart';

import '../io/download_file_example.dart';

Future<bool> downloadToGallery(String url) async {
  try {
    if (await Gal.requestAccess()) {
      final bytes = await downloadBinaryFile(url);
      await Gal.putImageBytes(bytes);
      return true;
    }
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
  }
  return false;
}
