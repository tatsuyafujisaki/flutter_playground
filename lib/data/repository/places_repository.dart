import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'places_repository.g.dart';

@Riverpod(keepAlive: true)
PlacesRepository placesRepository(Ref ref) => PlacesRepository();

class PlacesRepository {
  static const _apiKey = String.fromEnvironment('GOOGLE_MAPS_PLATFORM_API_KEY');

  Future<List<Map<String, dynamic>>> fetchNearbyCoffeeShops(
    double lat,
    double lng,
  ) async {
    if (_apiKey.isEmpty) {
      throw Exception('GOOGLE_MAPS_PLATFORM_API_KEY is not set');
    }

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?location=$lat,$lng'
      '&radius=1500'
      '&type=cafe'
      '&keyword=coffee'
      '&key=$_apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      return results.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load places: ${response.body}');
    }
  }
}
