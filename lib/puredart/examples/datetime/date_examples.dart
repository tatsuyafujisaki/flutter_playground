import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  final date = DateTime.now();

  print(DateFormat('yyyy-MM-dd hh:mm:ss').format(date)); // 2050年1月31日(月)

  print('--');

  await initializeDateFormatting('ja');

  print(DateFormat.MMMEd('ja').format(date)); // 1月31日(月)
  print(DateFormat.yMMMEd('ja').format(date)); // 2050年1月31日(月)
  print(DateFormat.Md('ja').format(date)); // 1/31
  print(DateFormat.MEd('ja').format(date)); // 1/31(月)
  print(DateFormat.yMEd('ja').format(date)); // 2050/1/31(月)
}
