import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:http/http.dart' as http;

Future<Uint8List?> centerCropImageFromPath(String imagePath) =>
    _centerCrop(_createImageBytesFromPath(imagePath));

Future<Uint8List?> centerCropImageFromUrl(String imageUrl) async =>
    _centerCrop(await _createImageBytesFromUrl(imageUrl));

Uint8List _createImageBytesFromPath(String imagePath) =>
    File(imagePath).readAsBytesSync();

Future<Uint8List> _createImageBytesFromUrl(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));
  return response.bodyBytes;
}

Future<Uint8List?> _centerCrop(Uint8List imageBytes) async {
  final image = await _decodeImage(imageBytes);
  final cropSize = min(image.width, image.height);
  final pictureRecorder = PictureRecorder();
  Canvas(pictureRecorder).drawImageRect(
    image,
    Rect.fromCenter(
      center: Offset(image.width / 2, image.height / 2),
      width: cropSize.toDouble(),
      height: cropSize.toDouble(),
    ),
    Rect.fromLTWH(0, 0, cropSize.toDouble(), cropSize.toDouble()),
    Paint(),
  );
  final croppedImage = await pictureRecorder.endRecording().toImage(
    cropSize,
    cropSize,
  );
  final byteData = await croppedImage.toByteData(format: ImageByteFormat.png);
  return byteData?.buffer.asUint8List();
}

Future<Image> _decodeImage(Uint8List list) async {
  final completer = Completer<Image>();
  decodeImageFromList(list, completer.complete);
  return completer.future;
}
