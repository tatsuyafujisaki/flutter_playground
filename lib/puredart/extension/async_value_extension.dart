import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';

extension on AsyncValue<dynamic> {
  // ignore: unused_element
  void printAll() => when(
    data: (data) => debugPrint('👀data: $data'),
    error:
        (error, stackTrace) =>
            debugPrint('👀(error, stackTrace): ($error, $stackTrace)'),
    loading: () => debugPrint('👀loading'),
  );
}
