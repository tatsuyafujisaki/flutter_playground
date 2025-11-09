import 'dart:async';

Timer _createAndStartNonPeriodicTimer([void Function()? callback]) =>
    Timer(const Duration(seconds: 3), () => callback?.call());

void main() {
  print('Timer started at ${DateTime.now()}');
  _createAndStartNonPeriodicTimer(
    () => print('Timer callback is called at ${DateTime.now()}'),
  );
}
