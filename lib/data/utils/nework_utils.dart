import 'dart:developer' as developer;
import 'dart:io';

import 'package:http/http.dart' as http;

Future<bool> get isOnline async {
  try {
    final internetAddresses = await InternetAddress.lookup('example.com');
    return internetAddresses.firstOrNull?.rawAddress.isNotEmpty ?? false;
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
    return false;
  }
}

Future<bool> isUrlAccessible(String url) async {
  try {
    final response = await http
        .head(Uri.parse(url))
        .timeout(const Duration(seconds: 10));

    return response.statusCode >= 200 && response.statusCode <= 299;
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
    return false;
  }
}
