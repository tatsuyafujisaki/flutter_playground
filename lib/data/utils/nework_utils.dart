import 'dart:developer' as developer;
import 'dart:io';

Future<bool> get isOnline async {
  try {
    final internetAddresses = await InternetAddress.lookup('example.com');
    return internetAddresses.firstOrNull?.rawAddress.isNotEmpty ?? false;
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
    return false;
  }
}
