import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  @override
  void initState() {
    super.initState();
    _currentPosition = _initialPosition;
  }

  String _getLatitudeText() =>
      _currentPosition?.target.latitude.toStringAsFixed(6) ?? '不明';

  String _getLongitudeText() =>
      _currentPosition?.target.longitude.toStringAsFixed(6) ?? '不明';

  String _getZoomText() => _currentPosition?.zoom.toStringAsFixed(2) ?? '不明';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Google Maps')),
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
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '現在の位置',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '緯度: ${_getLatitudeText()}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    '経度: ${_getLongitudeText()}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'ズーム: ${_getZoomText()}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
