import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'album.dart';

const _baseUrl = 'jsonplaceholder.typicode.com';

class AlbumModel {
  /// https://docs.flutter.dev/cookbook/networking/fetch-data#2-make-a-network-request
  Future<List<Album>> getAlbums() async {
    final uri = Uri.https(_baseUrl, 'albums');
    final response = await http.get(uri);
    if (_isSuccessful(response.statusCode)) {
      return (jsonDecode(response.body) as List<dynamic>)
          .map((map) => Album.fromJson(map as Map<String, dynamic>))
          .toList();
    }
    _log(response);
    throw Exception('Failed to get albums.');
  }

  /// https://docs.flutter.dev/cookbook/networking/fetch-data#2-make-a-network-request
  Future<Album> getAlbum({required int id}) async {
    final uri = Uri.https(_baseUrl, 'albums/$id');
    final response = await http.get(uri);
    if (_isSuccessful(response.statusCode)) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    _log(response);
    throw Exception('Failed to get an album.');
  }

  /// https://docs.flutter.dev/cookbook/networking/send-data#convert-the-http-response-to-an-album
  Future<Album> postAlbum({required Map<String, dynamic> body}) async {
    final uri = Uri.https(_baseUrl, 'albums');
    final response = await http.post(
      uri,
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      },
      body: jsonEncode(body),
    );
    if (_isSuccessful(response.statusCode)) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    _log(response);
    throw Exception('Failed to post an album.');
  }

  /// https://docs.flutter.dev/cookbook/networking/update-data#2-updating-data-over-the-internet-using-the-http-package
  Future<Album> updateAlbum({
    required int id,
    required Map<String, dynamic> body,
  }) async {
    final uri = Uri.https(_baseUrl, 'albums/$id');
    final response = await http.put(
      uri,
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      },
      body: jsonEncode(body),
    );
    if (_isSuccessful(response.statusCode)) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    _log(response);
    throw Exception('Failed to update an album.');
  }

  /// https://docs.flutter.dev/cookbook/networking/delete-data#2-delete-data-on-the-server
  Future<void> deleteAlbum({required int id}) async {
    final uri = Uri.https(_baseUrl, 'albums/$id');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      },
    );
    if (!_isSuccessful(response.statusCode)) {
      _log(response);
      throw Exception('Failed to delete an album.');
    }
  }

  bool _isSuccessful(int statusCode) => 200 <= statusCode && statusCode <= 299;

  void _log(Response response) {
    developer.log('👀response.request: ${response.request}');
    developer.log('👀response.statusCode: ${response.statusCode}');
    developer.log('👀response.reasonPhrase: ${response.reasonPhrase}');
    developer.log('👀response.headers: ${response.headers}');
    developer.log('👀response.body: ${response.body}');
  }
}

void main() async {
  final albumModel = AlbumModel();

  final albums = await albumModel.getAlbums();
  final album = await albumModel.getAlbum(id: 1);
  final postedAlbum = await albumModel.postAlbum(
    body: <String, dynamic>{'userId': 42, 'title': 'My posted album'},
  );
  final updatedAlbum = await albumModel.updateAlbum(
    id: 1,
    body: <String, dynamic>{'userId': 99, 'title': 'My updated album'},
  );

  developer.log(albums.toString());
  developer.log(album.toString());
  developer.log(postedAlbum.toString());
  developer.log(updatedAlbum.toString());
  await albumModel.deleteAlbum(id: 1);
}
