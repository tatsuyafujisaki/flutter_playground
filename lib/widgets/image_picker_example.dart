import 'package:flutter/material.dart';
import 'package:flutter_playground/packages/permission_handler_example.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

void main() => runApp(
      const MaterialApp(
        home: _MyStatelessWidget(),
      ),
    );

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (!await isPhotoGranted) {
          return;
        }
        final imagePickerPlatform = ImagePickerPlatform.instance;
        if (imagePickerPlatform is ImagePickerAndroid) {
          // > ImagePickerAndroid.useAndroidPhotoPicker must be set to true
          // > to use the limit functionality.
          // https://pub.dev/packages/image_picker_android
          imagePickerPlatform.useAndroidPhotoPicker = true;
        }
        final images = await ImagePicker().pickMultiImage(limit: 3);
        for (final image in images) {
          debugPrint('👀XFile > path: ${image.path}');
          debugPrint('👀XFile > name: ${image.name}');

          // Always null, except for the web platform.
          // https://github.com/flutter/flutter/issues/144900#issuecomment-1987332347
          debugPrint('👀XFile > mimeType: ${image.mimeType}');
        }
      },
    );
    return const FlutterLogo();
  }
}
