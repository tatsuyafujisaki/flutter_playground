import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'places_repository.g.dart';

@Riverpod(keepAlive: true)
PlacesRepository placesRepository(Ref ref) => PlacesRepository();

class PlacesRepository {
  static const _apiKey = String.fromEnvironment('GOOGLE_MAPS_PLATFORM_API_KEY');

  Future<List<Map<String, dynamic>>> fetchNearbyCoffeeShops(
    double latitude,
    double longitude,
  ) async {
    if (_apiKey.isEmpty) {
      throw Exception('GOOGLE_MAPS_PLATFORM_API_KEY is not set.');
    }

    // New Places API (New) endpoint
    final url = Uri.parse(
      'https://places.googleapis.com/v1/places:searchNearby',
    );

    // Request body for the new API
    final requestBody = json.encode({
      'includedTypes': ['cafe'],
      'locationRestriction': {
        'circle': {
          'center': {'latitude': latitude, 'longitude': longitude},
          'radius': 1500,
        },
      },
      'languageCode': 'ja',
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': _apiKey,
        // Specify which fields to return (affects billing)
        'X-Goog-FieldMask':
            'places.displayName,places.formattedAddress,'
            'places.location,places.types,places.rating,places.userRatingCount,'
            'places.websiteUri,places.id',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      developer.log('Raw response: ${response.body}');
      final data = json.decode(response.body) as Map<String, dynamic>;
      final places = data['places'] as List?;
      return places?.cast<Map<String, dynamic>>() ?? [];
    } else {
      throw Exception('Failed to load places: ${response.body}');
    }
  }
}
