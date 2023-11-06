import 'package:intl/intl.dart';

class DateUtil {
  static bool compareTo(DateTime a, DateTime b) {
    return DateTime(a.year, a.month, a.day)
                .compareTo(DateTime(b.year, b.month, b.day)) ==
            0
        ? true
        : false;
  }

  static String formatToYMD(DateTime d) {
    return DateFormat("yyyyMMdd").format(d);
  }
}
