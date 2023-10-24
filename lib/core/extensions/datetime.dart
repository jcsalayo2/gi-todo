extension DateTimeExtension on DateTime {
  int get lastDayOfMonth => DateTime(year, month + 1, 0).day;

  DateTime get lastDateOfMonth => DateTime(year, month + 1, 0);

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
