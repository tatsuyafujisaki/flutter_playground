import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class GeolocatorWrapper {
  factory GeolocatorWrapper() => _instance;
  GeolocatorWrapper._internal() {
    locationSettings = _locationSettings;
    isListening = false;
  }
  static final GeolocatorWrapper _instance = GeolocatorWrapper._internal();
  late final LocationSettings locationSettings;
  late bool isListening;

  LocationSettings get _locationSettings {
    if (Platform.isAndroid) {
      return AndroidSettings(
        // > (Optional) Set foreground notification config
        // > to keep the app alive when going to the background
        // https://pub.dev/documentation/geolocator/
        //
        // If you specify foregroundNotificationConfig,
        // you must specify the following in AndroidManifest.xml.
        // <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
        // Otherwise, you won't get any location updates
        // not only in the background but also in the foreground.
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationTitle: '',
          notificationText: '',
        ),
      );
    }
    if (Platform.isIOS) {
      return AppleSettings();
    }
    return const LocationSettings();
  }

  Future<bool> _checkAndRequestPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return false;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<Position?> get currentPosition async {
    if (await _checkAndRequestPermission()) {
      return Geolocator.getCurrentPosition();
    }
    return null;
  }

  Future<Stream<Position>?> get _positionStream async {
    if (await _checkAndRequestPermission()) {
      return Geolocator.getPositionStream(
        locationSettings: locationSettings,
      );
    }
    return null;
  }

  Future<void> listenOnce(void Function(Position) onData) async {
    // avoids accidentally adding multiple listeners to a broadcast stream
    // Geolocator.getPositionStream() returns.
    if (isListening) {
      return;
    }
    isListening = true;
    (await _positionStream)?.listen(
      onData,
      onError: (error) => debugPrint(error.toString()),
      onDone: () => isListening = false,
    );
  }

  void demoOneShot() {
    Future.delayed(
      Duration.zero,
      () async {
        final position = await GeolocatorWrapper().currentPosition;
        debugPrint(position.toString());
      },
    );
  }

  void demoListen() {
    Future.delayed(
      Duration.zero,
      () async {
        await GeolocatorWrapper().listenOnce(
          (position) => debugPrint(
            '$position, Time: ${DateFormat.Hms().format(DateTime.now())}',
          ),
        );
      },
    );
  }
}