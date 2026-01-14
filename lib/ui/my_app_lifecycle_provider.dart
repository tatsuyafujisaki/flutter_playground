import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_lifecycle_listener.dart';

part 'my_app_lifecycle_provider.g.dart';

@Riverpod(keepAlive: true)
MyAppLifecycleChangeNotifier appLifecycle(Ref ref) =>
    MyAppLifecycleChangeNotifier();
