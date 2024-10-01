import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_playground/packages/http_example.dart';

Future<ByteArrayAndroidBitmap> createLargeIcon(String url) async =>
    ByteArrayAndroidBitmap(await downloadBytes(url));
