String formatInMSs(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds.toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
