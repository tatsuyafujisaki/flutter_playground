import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';

/// Checks if a force update is required and shows a dialog if it is.
Future<void> showForceUpdateDialogIfNeeded(
  NavigatorState navigatorState,
) async {
  try {
    await FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: Duration.zero,
      ),
    );
    await FirebaseRemoteConfig.instance.fetchAndActivate();

    final minVersion = FirebaseRemoteConfig.instance.getString('min_version');

    if (!await _shouldForceUpdate(minVersion)) {
      return;
    }

    final storeUrl = await _storeUrl;
    if (storeUrl == null) {
      return;
    }

    await _showUpgradeDialog(navigatorState, storeUrl);
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
  }
}

Version? tryParse(String version) {
  try {
    return Version.parse(version);
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
    return null;
  }
}

Future<bool> _shouldForceUpdate(String minVersionString) async {
  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = tryParse(packageInfo.version) ?? Version.none;
  final minVersion = tryParse(minVersionString) ?? Version.none;
  return currentVersion < minVersion;
}

Future<String?> get _storeUrl async {
  if (Platform.isIOS) {
    // Replace with your actual App Store ID
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

Future<void> _showUpgradeDialog(
  NavigatorState navigatorState,
  String storeUrl,
) => showDialog<void>(
  context: navigatorState.context,
  barrierDismissible: false,
  builder: (context) => PopScope(
    canPop: false,
    child: AlertDialog(
      title: const Text('Update Required'),
      content: const Text(
        'A new version of the app is available. '
        'Please update to the latest version to continue using the app.',
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final uri = Uri.parse(storeUrl);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          child: const Text('Update'),
        ),
      ],
    ),
  ),
);
