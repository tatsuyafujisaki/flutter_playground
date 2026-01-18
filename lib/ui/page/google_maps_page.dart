import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/utils/geolocator_utils.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({super.key});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  CameraPosition? _currentPosition;
  Position? _userPosition;

  @override
  void initState() {
    super.initState();
    _currentPosition = _initialPosition;
  }

  String _getLatitudeText() =>
      _currentPosition?.target.latitude.toStringAsFixed(6) ?? 'Unknown';

  String _getLongitudeText() =>
      _currentPosition?.target.longitude.toStringAsFixed(6) ?? 'Unknown';

  String _getZoomText() =>
      _currentPosition?.zoom.toStringAsFixed(2) ?? 'Unknown';

  String _getAccuracyText() => _userPosition != null
      ? '${_userPosition!.accuracy.toStringAsFixed(2)}m'
      : 'Unknown';

  String _getUserLatitudeText() =>
      _userPosition?.latitude.toStringAsFixed(6) ?? 'Unknown';

  String _getUserLongitudeText() =>
      _userPosition?.longitude.toStringAsFixed(6) ?? 'Unknown';

  Future<void> _getCurrentLocation() async {
    try {
      final position = await getPosition();

      setState(() {
        _userPosition = position;
      });

      developer.log(
        'Current location: ${position.latitude}, ${position.longitude}',
      );
    } on Exception catch (error, stackTrace) {
      developer.log('', error: error, stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Google Maps')),
    floatingActionButton: FloatingActionButton(
      onPressed: _getCurrentLocation,
      tooltip: 'Get Current Location',
      child: const Icon(Icons.my_location),
    ),
    body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _initialPosition,
          onMapCreated: _controller.complete,
          onCameraMove: (position) {
            setState(() {
              _currentPosition = position;
            });
          },
        ),
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Camera Position',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Latitude: ${_getLatitudeText()}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Longitude: ${_getLongitudeText()}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Zoom: ${_getZoomText()}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'GPS Position',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Latitude: ${_getUserLatitudeText()}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Longitude: ${_getUserLongitudeText()}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Accuracy: ${_getAccuracyText()}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
