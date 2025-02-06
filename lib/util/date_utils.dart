import 'package:flutter/material.dart';

DateTime get today => DateUtils.dateOnly(DateTime.now());

bool isToday(DateTime dateTime) =>
    DateUtils.isSameDay(dateTime, DateTime.now());
