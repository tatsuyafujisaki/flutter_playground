import 'package:location/location.dart';

class LocationWrapper {
  final _location = Location();

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
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void> listen(void Function(LocationData) onData) async {
    if (await _isAllowed) {
      _location.onLocationChanged.listen(onData);
    }
  }
}
