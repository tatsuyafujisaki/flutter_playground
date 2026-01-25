// ignore_for_file: avoid_print
import 'package:stack_trace/stack_trace.dart';

void main() {
  try {
    throw Exception('💀');
  } on Exception catch (error, stackTrace) {
    print(error);
    print(Trace.from(stackTrace).terse);
  }
}
