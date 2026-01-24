import 'dart:developer' as developer;
import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

Future<bool> _shouldForceUpdate(String requiredVersion) async {
  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = _tryParseVersion(packageInfo.version) ?? Version.none;
  final requiredVersion1 = _tryParseVersion(requiredVersion) ?? Version.none;
  return currentVersion < requiredVersion1;
}

Version? _tryParseVersion(String version) {
  try {
    return Version.parse(version);
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
    return null;
  }
}

Future<String?> _getStoreUrl() async {
  if (Platform.isIOS) {
    const appStoreId = 'id544007664'; // dummy
    return 'https://apps.apple.com/app/id$appStoreId';
  }
  if (Platform.isAndroid) {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    return 'https://play.google.com/store/apps/details?id=$packageName';
  }
  return null;
}
