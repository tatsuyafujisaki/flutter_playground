import 'dart:async';
import 'dart:developer' as developer;

Timer _createAndStartNonPeriodicTimer([void Function()? callback]) =>
    Timer(const Duration(seconds: 3), () => callback?.call());

void main() {
  developer.log('Timer started at ${DateTime.now()}');
  _createAndStartNonPeriodicTimer(
    () => developer.log('Timer callback is called at ${DateTime.now()}'),
  );
}
