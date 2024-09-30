import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

ByteArrayAndroidBitmap convertToBitmap(Uint8List bytes) =>
    ByteArrayAndroidBitmap.fromBase64String(base64Encode(bytes));
