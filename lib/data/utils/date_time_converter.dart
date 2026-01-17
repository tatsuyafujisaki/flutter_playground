import 'package:intl/intl.dart';

class DateTimeConverter {
  const DateTimeConverter();
  static final _format = DateFormat('yyyy-MM-dd HH:mm:ss');

  DateTime? fromJson(String json) => _format.tryParse(json);

  String toJson(DateTime? dateTime) =>
      dateTime == null ? '' : _format.format(dateTime);
}
