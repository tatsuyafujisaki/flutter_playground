import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import '../view_model/album_view_model.dart';

@Preview()
Widget preview() => const _MyStatefulWidget();

class _MyStatefulWidget extends StatefulWidget {
  const _MyStatefulWidget();

  @override
  State<_MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  final albumViewModel = AlbumViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => albumViewModel.fetchAlbums(),
    );
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      body: ListenableBuilder(
        listenable: albumViewModel,
        builder: (context, child) => ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: albumViewModel.albums.length,
          itemBuilder: (context, index) =>
              Text(albumViewModel.albums[index].title ?? ''),
        ),
      ),
    ),
  );
}
