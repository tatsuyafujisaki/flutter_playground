import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  bool isBeforeOrEqualTo(DateTime other) => !isAfter(other);

  bool isAfterOrEqualTo(DateTime other) => !isBefore(other);

  DateTime get dateOnly => DateTime(year, month, day);

  bool get isToday => DateUtils.isSameDay(this, DateTime.now());
}
