import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'album.freezed.dart';
part 'album.g.dart';

/// https://jsonplaceholder.typicode.com/albums/1
@freezed
abstract class Album with _$Album {
  const factory Album({int? userId, int? id, String? title}) = _Album;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
}

void main() {
  const album = Album(userId: 0, id: 0, title: 'Title');
  final map = album.toJson();
  developer.log(map.toString());
  developer.log(Album.fromJson(map).toString());
  developer.log(jsonEncode(album)); // jsonEncode implicitly calls toJson.
}
