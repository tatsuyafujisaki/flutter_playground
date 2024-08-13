import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_playground/mvvm/album.dart';
import 'package:http/http.dart' as http;

const _baseUrl = 'jsonplaceholder.typicode.com';

class AlbumModel {
  /// https://docs.flutter.dev/cookbook/networking/fetch-data#2-make-a-network-request
  Future<List<Album>> getAlbums() async {
    final uri = Uri.https(_baseUrl, 'albums');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final mapList = jsonDecode(response.body) as List<dynamic>;
      return mapList
          .map((map) => Album.fromJson(map as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to get albums.');
    }
  }

  /// https://docs.flutter.dev/cookbook/networking/fetch-data#2-make-a-network-request
  Future<Album> getAlbum({required int id}) async {
    final uri = Uri.https(_baseUrl, 'albums/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to get an album.');
    }
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
    if (response.statusCode == 201) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to post an album.');
    }
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
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to update an album.');
    }
  }

  /// https://docs.flutter.dev/cookbook/networking/delete-data#2-delete-data-on-the-server
// ignore: unused_element
  Future<void> deleteAlbum({required int id}) async {
    final uri = Uri.https(_baseUrl, 'albums/$id');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete an album.');
    }
  }
}

void main() async {
  final albumModel = AlbumModel();

  debugPrint((await albumModel.getAlbums()).toString());
  debugPrint((await albumModel.getAlbum(id: 1)).toString());
  debugPrint(
    (await albumModel.postAlbum(
      body: <String, dynamic>{
        'userId': 42,
        'title': 'My album',
      },
    ))
        .toString(),
  );
  debugPrint(
    (await albumModel.updateAlbum(
      id: 1,
      body: <String, dynamic>{
        'userId': 420,
        'title': 'My updated album',
      },
    ))
        .toString(),
  );
  await albumModel.deleteAlbum(id: 1);
}
