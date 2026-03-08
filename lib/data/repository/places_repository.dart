// import 'dart:convert';
// import 'dart:developer' as developer;
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'places_repository.g.dart';

@Riverpod(keepAlive: true)
PlacesRepository placesRepository(Ref ref) => PlacesRepository();

class PlacesRepository {
  static const _apiKey = String.fromEnvironment('GOOGLE_MAPS_PLATFORM_API_KEY');

  // Allowed cafe chain names
  // static const _allowedCafeChains = [
  //   'CAFE DI ESPRESSO 珈琲館',
  //   'Cafe Miyama',
  //   'Cafe Renoir',
  //   'Cafeルノアール',
  //   'PRONTO',
  //   'THE SMOKIST COFFEE',
  //   'エクセルシオール',
  //   'カフェ・ド・クリエ',
  //   'サンマルクカフェ',
  //   'スターバックス',
  //   'タリーズ',
  //   'ドトール',
  //   'ブルーボトルコーヒー',
  //   'プロント',
  //   'ベローチェ',
  //   'ホリーズカフェ',
  //   'ミスタードーナツ',
  //   'メゾン・ド・ヴェール',
  //   'レクセル',
  //   '上島珈琲店',
  //   '猿田彦珈琲',
  //   "BECK'S COFFEE SHOP",
  //   "NEW YORKER'S Cafe",
  //   "Seattle's Best Coffee",
  // ];

  /// Checks if a cafe name matches any of the allowed chains
  // bool _isAllowedCafe(String? displayName) {
  //   if (displayName == null || displayName.isEmpty) {
  //     return false;
  //   }
  //
  //   return _allowedCafeChains.any((chain) => displayName.contains(chain));
  // }

  Future<List<Map<String, dynamic>>> fetchNearbyCoffeeShops(
    LatLng latLng,
  ) async {
    if (_apiKey.isEmpty) {
      throw Exception('GOOGLE_MAPS_PLATFORM_API_KEY is not set.');
    }

    // New Places API (New) endpoint
    // final url = Uri.parse(
    //   'https://places.googleapis.com/v1/places:searchNearby',
    // );
    //
    // // Request body for the new API
    // final requestBody = json.encode({
    //   'includedTypes': ['cafe'],
    //   'locationRestriction': {
    //     'circle': {
    //       'center': {
    //         'latitude': latLng.latitude,
    //         'longitude': latLng.longitude,
    //       },
    //       'radius': 1500,
    //     },
    //   },
    //   'languageCode': 'ja',
    // });

    // final response = await http.post(
    //   url,
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'X-Goog-Api-Key': _apiKey,
    //     // Specify which fields to return (affects billing)
    //     'X-Goog-FieldMask':
    //         'places.displayName,places.formattedAddress,'
    //         'places.location,places.types,places.rating,'
    //         'places.userRatingCount,'
    //         'places.websiteUri,places.id',
    //   },
    //   body: requestBody,
    // );
    //
    // if (response.statusCode == 200) {
    //   developer.log('Raw response: ${response.body}');
    //   final data = json.decode(response.body) as Map<String, dynamic>;
    //   final places = data['places'] as List?;
    //   final allPlaces = places?.cast<Map<String, dynamic>>() ?? [];
    //
    //   // Filter to only include allowed cafe chains
    //   final filteredPlaces = allPlaces.where((place) {
    //     final displayNameMap = place['displayName'] as Map<String, dynamic>?;
    //     final displayName = displayNameMap?['text'] as String?;
    //     return _isAllowedCafe(displayName);
    //   }).toList();
    //
    //   developer.log(
    //     'Filtered ${filteredPlaces.length} cafes '
    //     'from ${allPlaces.length} total places',
    //   );
    //   return filteredPlaces;
    // } else {
    //   throw Exception('Failed to load places: ${response.body}');
    // }

    // Simulate returning no result
    return [];
  }
}
