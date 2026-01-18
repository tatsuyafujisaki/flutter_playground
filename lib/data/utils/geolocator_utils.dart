import 'package:geolocator/geolocator.dart';

Future<Position> getPosition() async {
  LocationPermission permission;

  final locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!locationServiceEnabled) {
    return Future.error('Location service is disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permission is denied.');
    }
  }

  return permission == LocationPermission.deniedForever
      ? Future.error('Location permission is permanently denied.')
      : Geolocator.getCurrentPosition();
}
