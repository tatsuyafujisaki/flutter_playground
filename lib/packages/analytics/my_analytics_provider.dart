import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'my_analytics_service.dart';

part 'my_analytics_provider.g.dart';

@riverpod
MyAnalyticsService analyticsService(Ref ref) => MyAnalyticsService();
