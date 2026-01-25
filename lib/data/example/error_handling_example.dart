import 'dart:developer' as developer;

import 'package:stack_trace/stack_trace.dart';

void main() {
  try {
    throw Exception('💀');
  } on Exception catch (error, stackTrace) {
    developer.log('-- Error and stack trace --');
    developer.log('', error: error, stackTrace: stackTrace);
    developer.log('-- Error and stack trace with less noise --');
    developer.log('', error: error, stackTrace: Trace.from(stackTrace).terse);
  }
}
