import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

Future<bool> shouldForceUpdate(String requiredVersion) async {
  final info = await PackageInfo.fromPlatform();
  return Version.parse(info.version) < Version.parse(requiredVersion);
}
