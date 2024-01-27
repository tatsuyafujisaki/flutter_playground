import 'package:location/location.dart';

class LocationWrapper {
  final location = Location();

  Future<bool> get isAllowed async {
    if (!await location.serviceEnabled() && !await location.requestService()) {
      return false;
    }
    if (!await location.isBackgroundModeEnabled() &&
        !await location.enableBackgroundMode()) {
      return false;
    }
    var status = await location.hasPermission();
    if (status == PermissionStatus.denied) {
      status = await location.requestPermission();
    }
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void> listen(void Function(LocationData) onData) async {
    if (await isAllowed) {
      location.onLocationChanged.listen(onData);
    }
  }
}
