// ignore: unreachable_from_main
Duration copyMinutesAndSeconds(Duration duration) => Duration(
  minutes: duration.inMinutes % Duration.minutesPerHour,
  seconds: duration.inSeconds % Duration.secondsPerMinute,
);

// Returns 34:56 if Duration is 12:34:56.123456
String formatInMSs(Duration duration) =>
    duration.toString().split('.').first.substring(3);

void main() {
  const duration = Duration(
    hours: 12,
    minutes: 34,
    seconds: 56,
    milliseconds: 123,
    microseconds: 456,
  );
  print(duration); // 12:34:56.123456
  print(formatInMSs(duration)); // 34:56
}
