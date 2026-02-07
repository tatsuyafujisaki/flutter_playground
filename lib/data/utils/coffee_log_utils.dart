import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../repository/places_repository.dart';
import 'geolocator_utils.dart';

Future<void> logNearbyCoffeeChains(ProviderContainer container) async {
  try {
    developer.log('Checking nearby coffee chains...');

    final position = await getPosition();
    developer.log(
      'Current position: ${position.latitude}, ${position.longitude}',
    );

    final repository = container.read(placesRepositoryProvider);
    final shops = await repository.fetchNearbyCoffeeShops(
      LatLng(position.latitude, position.longitude),
    );

    if (shops.isEmpty) {
      developer.log('No coffee shops found nearby.');
      return;
    }

    developer.log('--- Nearby Coffee Chains ---');
    for (final shop in shops) {
      final name = shop['name'];
      final address = shop['vicinity'];
      final rating = shop['rating'];
      developer.log('Name: $name, Address: $address, Rating: $rating');
    }
    developer.log('----------------------------');
  } on Exception catch (e) {
    developer.log('Error logging nearby coffee chains: $e');
  }
}
