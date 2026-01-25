import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:image_picker/image_picker.dart';
import '../../packages/permission_handler_example.dart';

@Preview()
Widget preview() => const _MyStatelessWidget();

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!await isPhotoGranted) {
        return;
      }
      final images = await ImagePicker().pickMultiImage(limit: 3);
      for (final image in images) {
        developer.log('👀XFile > path: ${image.path}');
        developer.log('👀XFile > name: ${image.name}');

        // Always null, except for the web platform.
        // https://github.com/flutter/flutter/issues/144900#issuecomment-1987332347
        developer.log('👀XFile > mimeType: ${image.mimeType}');
      }
    });
    return const FlutterLogo();
  }
}
