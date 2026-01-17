import 'dart:developer' as developer;

void main() {
  try {
    throw Exception('💀');
  } on Exception catch (error, stackTrace) {
    developer.log('An error occurred', error: error, stackTrace: stackTrace);
  }
}
