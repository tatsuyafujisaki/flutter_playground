import 'dart:developer' as developer;

import 'package:flutter/material.dart';

/// This example shows that [DateUtils.isSameDay] ignores time zones.
void main() {
  final dateTime1 = DateTime.utc(2050, 1, 1, 23);
  developer.log('dateTime1: $dateTime1');
  final dateTime2 = DateTime(2050, 1, 2, 8);
  developer.log('dateTime2: $dateTime2');
  // false
  developer.log(
    '''dateTime1 == dateTime2: ${DateUtils.isSameDay(dateTime1, dateTime2)}''',
  );
  // true
  developer.log(
    '''dateTime1.toLocal() == dateTime2: ${DateUtils.isSameDay(dateTime1.toLocal(), dateTime2)}''',
  );
}
