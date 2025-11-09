import 'dart:io';

Future<bool> get isOnline async {
  try {
    final internetAddresses = await InternetAddress.lookup('example.com');
    return internetAddresses.firstOrNull?.rawAddress.isNotEmpty ?? false;
  } on SocketException catch (_) {
    return false;
  }
}
