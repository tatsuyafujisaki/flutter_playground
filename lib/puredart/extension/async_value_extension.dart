import 'package:riverpod/riverpod.dart';

extension on AsyncValue<dynamic> {
  // ignore: unused_element
  void printAll() => when(
    data: (data) => print('👀data: $data'),
    error:
        (error, stackTrace) =>
            print('👀(error, stackTrace): ($error, $stackTrace)'),
    loading: () => print('👀loading'),
  );
}
