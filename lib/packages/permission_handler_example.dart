import 'package:permission_handler/permission_handler.dart';

Future<bool> get isMicrophoneAllowed async => Permission.microphone
    .onPermanentlyDeniedCallback(() async => openAppSettings())
    .request()
    .isGranted;
