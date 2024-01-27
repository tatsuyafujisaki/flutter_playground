import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class GeolocatorWrapper {
  factory GeolocatorWrapper() => _instance;
  GeolocatorWrapper._internal() {
    _controller = StreamController();
  }
  static final GeolocatorWrapper _instance = GeolocatorWrapper._internal();
  late final StreamController<Position> _controller;

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

  Future<bool> get isAllowed async {
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

  Future<Position?> get currentPosition async =>
      await isAllowed ? Geolocator.getCurrentPosition() : null;

  Future<Stream<Position>?> get _positionStream async => (await isAllowed)
      ? Geolocator.getPositionStream(locationSettings: _locationSettings)
      : null;

  Future<void> listenOnce(void Function(Position) onData) async {
    // avoids accidentally adding multiple listeners to a broadcast stream
    // Geolocator.getPositionStream() returns.
    final positionStream = await _positionStream;
    if (!_controller.hasListener && positionStream != null) {
      await _controller.addStream(positionStream);
    }
    _controller.stream.listen(onData);
  }

  void demoOneShot() {
    Future.delayed(
      Duration.zero,
      () => debugPrint(currentPosition.toString()),
    );
  }

  void demoListen() {
    Future.delayed(
      Duration.zero,
      () async => GeolocatorWrapper().listenOnce(
        (position) => debugPrint(
          '$position, Time: ${DateFormat.Hms().format(DateTime.now())}',
        ),
      ),
    );
  }
}
