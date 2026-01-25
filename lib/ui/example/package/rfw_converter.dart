import 'dart:io';
import 'package:rfw/formats.dart';

void main() {
  const rfwText = 'Put your RFW text here.';
  final remoteWidgetLibrary = parseLibraryFile(rfwText);
  final bytes = encodeLibraryBlob(remoteWidgetLibrary);
  File('output.rfw').writeAsBytesSync(bytes);
}
