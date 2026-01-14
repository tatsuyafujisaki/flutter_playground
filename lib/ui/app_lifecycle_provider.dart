import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_lifecycle_listener.dart';

/// Provider for app lifecycle state management
final appLifecycleProvider = Provider<AppLifecycleProvider>(
  (ref) => AppLifecycleProvider(),
);
