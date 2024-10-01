import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_playground/packages/http_example.dart';

Future<ByteArrayAndroidBitmap> createLargeIcon(String url) async =>
    _convertToBitmap(await downloadBytes(url));

ByteArrayAndroidBitmap _convertToBitmap(Uint8List bytes) =>
    ByteArrayAndroidBitmap.fromBase64String(base64Encode(bytes));
