import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

Future<bool> shouldForceUpdate(String requiredVersion) async {
  final info = await PackageInfo.fromPlatform();
  return Version.parse(info.version) < Version.parse(requiredVersion);
}

Future<String?> _getStoreUrl() async {
  if (Platform.isIOS) {
    // YouTube as a dummy
    const appStoreId = 'id544007664';
    return 'https://apps.apple.com/app/id$appStoreId';
  }
  if (Platform.isAndroid) {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    return 'https://play.google.com/store/apps/details?id=$packageName';
  }
  return null;
}
