import 'dart:ui' as ui;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:http/http.dart' as http;

final youtubeRepositoryProvider = Provider<YoutubeRepository>(
  (ref) => YoutubeRepository(),
);

class YoutubeRepository {
  static const _apiKey = String.fromEnvironment('YOUTUBE_API_KEY');

  String _getRegionCode() {
    final countryCode = ui.PlatformDispatcher.instance.locale.countryCode;
    return (countryCode != null && countryCode.isNotEmpty) ? countryCode : 'US';
  }

  Future<List<Video>> fetchPopularVideos() async {
    final client = _ApiKeyClient(_apiKey);
    final youtube = YouTubeApi(client);

    try {
      final regionCode = _getRegionCode();
      final response = await youtube.videos.list(
        ['snippet', 'contentDetails', 'statistics'],
        chart: 'mostPopular',
        maxResults: 50,
        regionCode: regionCode,
      );

      final videos = response.items ?? [];
      return videos;
    } finally {
      client.close();
    }
  }
}

class _ApiKeyClient extends http.BaseClient {
  _ApiKeyClient(this._key);
  final String _key;
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final queryParameters = Map<String, dynamic>.from(
      request.url.queryParametersAll,
    );
    queryParameters['key'] = [_key];

    final url = request.url.replace(queryParameters: queryParameters);

    final newRequest = http.Request(request.method, url);
    newRequest.headers.addAll(request.headers);

    if (request is http.Request) {
      newRequest
        ..bodyBytes = request.bodyBytes
        ..followRedirects = request.followRedirects
        ..maxRedirects = request.maxRedirects
        ..persistentConnection = request.persistentConnection;
    }

    return _inner.send(newRequest);
  }
}
