import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gal/gal.dart';

import '../io/download_file_example.dart';

Future<bool> downloadToGallery(String url) async {
  try {
    if (await Gal.requestAccess()) {
      final bytes = await downloadBinaryFile(url);
      await Gal.putImageBytes(bytes);
      return true;
    }
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
  return false;
}
