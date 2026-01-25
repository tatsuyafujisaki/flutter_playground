// ignore_for_file: avoid_print
import 'package:stack_trace/stack_trace.dart';

void main() {
  try {
    throw Exception('💀');
  } on Exception catch (error, stackTrace) {
    print('-- Error --');
    print(error);
    print('-- Stack trace --');
    print(stackTrace);
    print('-- Stack trace with less noise --');
    print(Trace.from(stackTrace).terse);
  }
}
