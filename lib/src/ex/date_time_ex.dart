extension DateTimeEx on DateTime {
  DateTime get startDayTime => DateTime(year, month, day);

  DateTime get endDayTime => DateTime(year, month, day + 1).startDayTime;

  bool isSameYear(DateTime other) => year == other.year;

  bool isSameMonth(DateTime other) => isSameYear(other) && month == other.month;

  bool isSameDay(DateTime other) => isSameMonth(other) && day == other.day;
}
