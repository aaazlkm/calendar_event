import 'package:calendar_event/calendar_event.dart';

List<Day> createCalendarDays({
  required DateTime yearMonth,
  required DayOfWeek startDayOfWeek,
  required List<Holiday> holidays,
}) {
  final startDateInMonth = DateTime(yearMonth.year, yearMonth.month);
  final endDateInMonth = DateTime(yearMonth.year, yearMonth.month + 1, 0);
  final offset = startDayOfWeek.calculateOffset(to: DayOfWeekEx.from(dateTime: startDateInMonth));
  final startDayInCalendar = startDateInMonth.addAmount(dayAmount: -offset);
  final endDayOfWeekInMonth = DayOfWeekEx.from(dateTime: endDateInMonth); //　月の最後の曜日
  final endDayOfWeekInCalendar = startDayOfWeek.previous; // カレンダー内で表示される最後の曜日
  final nextMonthDays = endDayOfWeekInMonth.calculateOffset(to: endDayOfWeekInCalendar); // カレンダー内で表示される次の月の日数
  final addExtraWeek = nextMonthDays <= 2 ? 1 : 0; // 余分に追加する週数。次の月の日数が2以下の場合fabと被るため、余分な週を追加する
  // 週数
  final weeksPerCalendar = (endDateInMonth.difference(startDayInCalendar).inDays ~/ DateTime.daysPerWeek + 1) + addExtraWeek;
  final calendarDates = List.generate(weeksPerCalendar * DateTime.daysPerWeek, (i) => i).map(
    (i) {
      final date = startDayInCalendar.addAmount(dayAmount: i);
      return Day(
        dateTime: date,
        holidays: holidays.where((holiday) => DateRange.day(day: date).isInRange(holiday.dateRange)).toList(),
        dayInCalendarState: yearMonth.month == date.month ? DayInCalendarMonthState.thisMonth : DayInCalendarMonthState.otherMonth,
      );
    },
  ).toList();
  return calendarDates;
}
