import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class LocationWrapper {
  static final _location = Location();
  static StreamSubscription<LocationData>? subscription;

  Future<bool> get _isAllowed async {
    if (!await _location.serviceEnabled() &&
        !await _location.requestService()) {
      return false;
    }
    if (!await _location.isBackgroundModeEnabled() &&
        !await _location.enableBackgroundMode()) {
      return false;
    }
    var status = await _location.hasPermission();
    if (status == PermissionStatus.denied) {
      status = await _location.requestPermission();
    }
    return {PermissionStatus.granted, PermissionStatus.grantedLimited}
        .contains(status);
  }

  Future<LocationData?> get location async =>
      await _isAllowed ? _location.getLocation() : null;

  Future<void> listen(void Function(LocationData) onData) async {
    if (!await _isAllowed) {
      return;
    }
    await _location.changeSettings(
      interval: 15000,
    );
    await subscription?.cancel();
    subscription = _location.onLocationChanged.listen(onData);
  }

  void demoOneShot() {
    Future.delayed(
      Duration.zero,
      () => debugPrint(location.toString()),
    );
  }

  void demoListen() {
    Future.delayed(
      Duration.zero,
      () async => listen(
        (data) => debugPrint(
          '$data, Time: ${DateFormat.Hms().format(DateTime.now())}',
        ),
      ),
    );
  }
}
