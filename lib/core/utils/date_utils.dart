import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static String formatDate(
    String? date, {
    String pattern = 'MMMM d, yyyy',
    String locale = 'en',
  }) {
    if (date == null || date.trim().isEmpty) {
      return '';
    }

    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat(pattern, locale).format(parsedDate);
    } on FormatException {
      return date;
    }
  }

  static String formatDateTime(
    String? dateTime, {
    String pattern = 'MMMM d, yyyy • h:mm a',
    String locale = 'en',
  }) {
    return formatDate(dateTime, pattern: pattern, locale: locale);
  }
}
