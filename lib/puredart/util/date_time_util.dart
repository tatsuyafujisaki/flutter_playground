import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

// ignore: unreachable_from_main
DateTime removeSeconds(DateTime dateTime) => DateTime(
  dateTime.year,
  dateTime.month,
  dateTime.day,
  dateTime.hour,
  dateTime.minute,
);

// 0:00 instead of 00:00
DateFormat get mSsDateFormat => DateFormat('m:ss');

void main() {
  final dateTime = DateTime.now();
  debugPrint(mSsDateFormat.format(dateTime));
}
