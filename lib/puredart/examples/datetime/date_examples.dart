import 'package:flutter/foundation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  final date = DateTime.now();

  debugPrint(DateFormat('yyyy-MM-dd hh:mm:ss').format(date)); // 2050年1月31日(月)

  debugPrint('--');

  await initializeDateFormatting('ja');

  debugPrint(DateFormat.MMMEd('ja').format(date)); // 1月31日(月)
  debugPrint(DateFormat.yMMMEd('ja').format(date)); // 2050年1月31日(月)
  debugPrint(DateFormat.Md('ja').format(date)); // 1/31
  debugPrint(DateFormat.MEd('ja').format(date)); // 1/31(月)
  debugPrint(DateFormat.yMEd('ja').format(date)); // 2050/1/31(月)
}
