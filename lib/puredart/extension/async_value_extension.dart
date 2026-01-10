import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension on AsyncValue<dynamic> {
  // ignore: unused_element
  void printAll() => when(
    data: (data) => developer.log('👀data: $data'),
    error: (error, stackTrace) =>
        developer.log('👀(error, stackTrace): ($error, $stackTrace)'),
    loading: () => developer.log('👀loading'),
  );
}
