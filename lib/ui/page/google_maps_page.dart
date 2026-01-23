import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

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

      final customIcon = await _createCustomMarkerIcon();

      if (!mounted) {
        return;
      }

      setState(() {
        _currentPosition = cameraPosition;
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(position.latitude, position.longitude),
            icon: customIcon,
            infoWindow: const InfoWindow(title: 'Your location'),
            onTap: () => _showImageDialog(context),
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

  Future<BitmapDescriptor> _createCustomMarkerIcon() async {
    try {
      final response = await http.get(
        Uri.parse('https://picsum.photos/100/100'),
      );
      final imageData = response.bodyBytes;
      return BitmapDescriptor.bytes(imageData);
    } on Exception catch (error, stackTrace) {
      developer.log(
        'Failed to load marker image',
        error: error,
        stackTrace: stackTrace,
      );
      return BitmapDescriptor.defaultMarker;
    }
  }

  Future<void> _showImageDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '画像',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Image.network(
                'https://picsum.photos/400/300',
                fit: BoxFit.contain,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  }
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Center(
                  child: Icon(Icons.error, size: 48),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
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
