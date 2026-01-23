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
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return false;
    }

    final response = await http.head(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    }

    if (response.statusCode == 405) {
      final response2 = await http
          .get(uri)
          .timeout(const Duration(seconds: 10));
      return response2.statusCode >= 200 && response2.statusCode < 300;
    }
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
  }
  return false;
}
