import 'package:flutter/material.dart';

/// This example shows that [DateUtils.isSameDay] ignores time zones.
void main() {
  final dateTime1 = DateTime.utc(2050, 1, 1, 23);
  debugPrint('dateTime1: $dateTime1');
  final dateTime2 = DateTime(2050, 1, 2, 8);
  debugPrint('dateTime2: $dateTime2');
  // false
  debugPrint(
    '''dateTime1 == dateTime2: ${DateUtils.isSameDay(dateTime1, dateTime2)}''',
  );
  // true
  debugPrint(
    '''dateTime1.toLocal() == dateTime2: ${DateUtils.isSameDay(dateTime1.toLocal(), dateTime2)}''',
  );
}
