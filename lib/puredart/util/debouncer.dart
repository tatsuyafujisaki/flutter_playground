import 'dart:async';

class Debouncer {
  Debouncer(this.duration);
  final Duration duration;
  Timer? _timer;

  void run(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }
}

Timer _createAndStartPeriodicTimer([void Function()? callback]) =>
    Timer.periodic(const Duration(seconds: 1) /* inteval */, (timer) {
      print('Timer.tick: ${timer.tick}');
      callback?.call();
    });

void main() {
  final debouncer = Debouncer(const Duration(seconds: 3));

  final timer1 = _createAndStartPeriodicTimer();

  final timer2 = Timer(
    const Duration(seconds: 2),
    () => debouncer.run(
      () => print('Debouncer: 2 seconds passed without another call.'),
    ),
  );

  final timer3 = Timer(
    const Duration(seconds: 4),
    () => debouncer.run(
      () => print('Debouncer: 4 seconds passed without another call.'),
    ),
  );

  Future<void>.delayed(const Duration(seconds: 60), () {
    timer1.cancel();
    timer2.cancel();
    timer3.cancel();
  });
}
