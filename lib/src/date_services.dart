import 'package:intl/intl.dart';

class DateServices {
  static String formateTime(String time) =>
      DateFormat.jm().format(DateTime.parse(time).toLocal());
  static String formateDateTime(String date) =>
      DateFormat("d MMMM yy").format(DateTime.parse(date).toLocal());

  static String formateTime12Hour(String time) =>
      DateFormat("h:mm a").format(DateTime.parse(time).toLocal());

  static String formateStandartDate(String date) {
    return "${formateDateTime(date)} ${formateTime12Hour(date)} ";
  }
}
