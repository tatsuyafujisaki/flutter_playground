import 'dart:async';
import 'dart:developer' as developer;

void main() {
  final stopwatch = Stopwatch();
  developer.log(stopwatch.elapsed.toString()); // 0
  developer.log(stopwatch.isRunning.toString()); // false
  stopwatch.start();
  developer.log(stopwatch.isRunning.toString()); // true
  Future<void>.delayed(const Duration(seconds: 3), () {
    stopwatch.stop();
    developer.log(stopwatch.elapsed.toString()); // 3 seconds
    developer.log(stopwatch.isRunning.toString()); // false
  });
}
