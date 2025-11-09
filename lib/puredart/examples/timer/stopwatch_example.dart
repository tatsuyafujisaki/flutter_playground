import 'dart:async';

void main() {
  final stopwatch = Stopwatch();
  print(stopwatch.elapsed); // 0
  print(stopwatch.isRunning); // false
  stopwatch.start();
  print(stopwatch.isRunning); // true
  Future<void>.delayed(const Duration(seconds: 3), () {
    stopwatch.stop();
    print(stopwatch.elapsed); // 3 seconds
    print(stopwatch.isRunning); // false
  });
}
