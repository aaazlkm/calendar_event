extension DateTimeEx on DateTime {
  DateTime get startDayTime => DateTime(year, month, day);

  DateTime get endDayTime => DateTime(year, month, day + 1).startDayTime;

  bool isSameYear(DateTime other) => year == other.year;

  bool isSameMonth(DateTime other) => isSameYear(other) && month == other.month;

  bool isSameDay(DateTime other) => isSameMonth(other) && day == other.day;

  DateTime addAmount({
    int? yearAmount,
    int? monthAmount,
    int? dayAmount,
    int? hourAmount,
    int? minuteAmount,
    int? secondAmount,
    int? millisecondAmount,
    int? microsecondAmount,
  }) =>
      DateTime(
        year + (yearAmount ?? 0),
        month + (monthAmount ?? 0),
        day + (dayAmount ?? 0),
        hour + (hourAmount ?? 0),
        minute + (minuteAmount ?? 0),
        second + (secondAmount ?? 0),
        millisecond + (millisecondAmount ?? 0),
        microsecond + (microsecondAmount ?? 0),
      );
}
