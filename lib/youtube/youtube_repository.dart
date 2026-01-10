import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:http/http.dart' as http;

final youtubeRepositoryProvider = Provider<YoutubeRepository>((ref) {
  return YoutubeRepository();
});

class YoutubeRepository {
  // TODO: Replace with your actual API Key
  static const _apiKey = 'YOUR_API_KEY_HERE';

  Future<List<Video>> fetchPopularVideos() async {
    final client = _ApiKeyClient(_apiKey);
    final youtube = YouTubeApi(client);

    try {
      final response = await youtube.videos.list(
        ['snippet', 'contentDetails', 'statistics'],
        chart: 'mostPopular',
        maxResults: 50,
        // Optional: regionCode to get popular videos in specific region
        regionCode: 'JP',
      );

      return response.items ?? [];
    } finally {
      client.close();
    }
  }
}

class _ApiKeyClient extends http.BaseClient {
  final String _key;
  final http.Client _inner = http.Client();

  _ApiKeyClient(this._key);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final url = request.url.replace(
      queryParameters: <String, String>{
        ...request.url.queryParameters,
        'key': _key,
      },
    );

    final newRequest = http.Request(request.method, url);
    newRequest.headers.addAll(request.headers);

    if (request is http.Request) {
      newRequest.bodyBytes = request.bodyBytes;
      newRequest.followRedirects = request.followRedirects;
      newRequest.maxRedirects = request.maxRedirects;
      newRequest.persistentConnection = request.persistentConnection;
    }

    return _inner.send(newRequest);
  }
}
