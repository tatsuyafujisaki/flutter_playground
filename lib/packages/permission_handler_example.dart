import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

/// To access photos and videos, use [isPhotoGranted] instead.
///
/// > Call request() on a Permission to request it. If it has already been
/// > granted before, nothing happens. request() returns the new status of
/// > the Permission.
/// https://pub.dev/packages/permission_handler
Future<bool> isGranted<T extends Permission>(T permission) async => permission
    .onPermanentlyDeniedCallback(() async => openAppSettings())
    .request()
    .isGranted;

Future<bool> get isPhotoGranted async {
  /// > Devices running Android 12 (API level 32) or lower:
  ///   use Permissions.storage.
  /// > Devices running Android 13 (API level 33) and above:
  ///   Should use Permissions.photos.
  /// https://pub.dev/documentation/permission_handler/latest/permission_handler/Permission/photos-constant.html
  Future<bool> shouldUseStorage() async =>
      Platform.isAndroid &&
      (await DeviceInfoPlugin().androidInfo).version.sdkInt <= 32;

  return isGranted(
    await shouldUseStorage() ? Permission.storage : Permission.photos,
  );
}
