import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';

const _requiredVersionKey = 'required_version';

/// Checks if a force update is required and shows a dialog if it is.
Future<void> showForceUpdateDialogIfNeeded(BuildContext context) async {
  try {
    await FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: Duration.zero,
      ),
    );
    await FirebaseRemoteConfig.instance.fetchAndActivate();

    final requiredVersion = FirebaseRemoteConfig.instance.getString(
      _requiredVersionKey,
    );

    if (!await _shouldForceUpdate(requiredVersion)) {
      return;
    }

    final url = await _getStoreUrl();

    if (context.mounted) {
      await _showUpgradeDialog(context, url);
    }
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
  }
}

Future<bool> _shouldForceUpdate(String requiredVersion) async {
  Version? tryParse(String version) {
    try {
      return Version.parse(version);
    } on Exception catch (error, stackTrace) {
      developer.log('', error: error, stackTrace: stackTrace);
      return null;
    }
  }

  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = tryParse(packageInfo.version) ?? Version.none;
  final requiredVersion1 = tryParse(requiredVersion) ?? Version.none;
  return currentVersion < requiredVersion1;
}

Future<String> _getStoreUrl() async {
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
  throw UnimplementedError();
}

Future<void> _showUpgradeDialog(BuildContext context, String storeUrl) async =>
    showDialog<void>(
      context: context,
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
