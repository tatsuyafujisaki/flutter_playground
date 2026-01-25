import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
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

  CameraPosition? _currentPosition;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => _getCurrentLocation(),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await getPosition();

      final cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      );

      setState(() {
        _currentPosition = cameraPosition;
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'Your location'),
          ),
        );
      });

      final controller = await _controller.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );

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
    body: SafeArea(
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                _currentPosition ??
                const CameraPosition(
                  target: LatLng(35.6812, 139.7671), // 東京駅の座標（デフォルト）
                  zoom: 14.4746,
                ),
            onMapCreated: _controller.complete,
            onCameraMove: (position) {
              setState(() {
                _currentPosition = position;
              });
            },
            markers: _markers,
          ),
        ],
      ),
    ),
  );
}
