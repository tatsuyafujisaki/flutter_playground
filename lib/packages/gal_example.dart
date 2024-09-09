import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_playground/packages/http_example.dart';
import 'package:gal/gal.dart';

Future<void> downloadImageToGallery(String url) async {
  try {
    if (!await Gal.requestAccess()) {
      return;
    }
    final bytes = await downloadBinaryFile(url);
    await Gal.putImageBytes(bytes);
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
}
