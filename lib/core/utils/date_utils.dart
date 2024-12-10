import 'package:intl/intl.dart';

class DateUtils {
  static String formatDate(DateTime date, String format) {
    return DateFormat(format).format(date);
  }

  static DateTime parseDate(String date, String format) {
    return DateFormat(format).parse(date);
  }

  static String getCurrentDate(String format) {
    return DateFormat(format).format(DateTime.now());
  }
}
