import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'album.dart';
import 'album_model.dart';

/// https://docs.flutter.dev/get-started/fwe/state-management#defining-the-viewmodel
/// https://docs.flutter.dev/data-and-backend/state-mgmt/simple
class AlbumViewModel extends ChangeNotifier {
  final _albumModel = AlbumModel();

  var _albums = <Album>[];
  UnmodifiableListView<Album> get albums => UnmodifiableListView(_albums);

  late Album _album;
  Album get album => _album;

  Future<void> fetchAlbums() async {
    try {
      _albums = await _albumModel.getAlbums();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> fetchAlbum({required int id}) async {
    try {
      _album = await _albumModel.getAlbum(id: id);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> postAlbum({required Map<String, dynamic> body}) async {
    try {
      _album = await _albumModel.postAlbum(body: body);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> deleteAlbum({required int id}) async {
    try {
      await _albumModel.deleteAlbum(id: id);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }
}
