import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/repository/places_repository.dart';
import '../../data/utils/geolocator_utils.dart';

class GoogleMapsPage extends ConsumerStatefulWidget {
  const GoogleMapsPage({super.key});

  @override
  ConsumerState<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends ConsumerState<GoogleMapsPage> {
  final _controller = Completer<GoogleMapController>();

  CameraPosition? _currentPosition;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getCurrentLocation());
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
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
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

      // Fetch nearby cafes
      await _fetchNearbyCafes(position.latitude, position.longitude);
    } on Exception catch (error, stackTrace) {
      developer.log('', error: error, stackTrace: stackTrace);
    }
  }

  Future<void> _fetchNearbyCafes(double latitude, double longitude) async {
    try {
      final repository = ref.read(placesRepositoryProvider);
      final cafes = await repository.fetchNearbyCoffeeShops(
        LatLng(latitude, longitude),
      );

      developer.log('Fetched ${cafes.length} allowed cafes');

      final cafeMarkers = cafes
          .map((cafe) {
            final location = cafe['location'] as Map<String, dynamic>?;
            final latitude = location?['latitude'] as double?;
            final longitude = location?['longitude'] as double?;
            final displayName = cafe['displayName'] as Map<String, dynamic>?;
            final text = displayName?['text'] as String? ?? 'Unknown Cafe';
            final address = cafe['formattedAddress'] as String? ?? '';
            final id = cafe['id'] as String? ?? '';
            final websiteUri = cafe['websiteUri'] as String?;

            if (latitude == null || longitude == null) {
              return null;
            }

            return Marker(
              markerId: MarkerId(id),
              position: LatLng(latitude, longitude),
              infoWindow: InfoWindow(
                title: text,
                snippet: address,
                onTap: websiteUri != null
                    ? () async {
                        final uri = Uri.parse(websiteUri);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          developer.log('Could not launch $websiteUri');
                        }
                      }
                    : null,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
            );
          })
          .whereType<Marker>()
          .toSet();

      setState(() {
        _markers.addAll(cafeMarkers);
      });

      developer.log('Added ${cafeMarkers.length} cafe markers to the map');
    } on Exception catch (error, stackTrace) {
      developer.log(
        'Error fetching cafes',
        error: error,
        stackTrace: stackTrace,
      );
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
