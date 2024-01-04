import 'package:calendar_event/calendar_event.dart';
import 'package:calendar_event/src/ex/date_time_ex.dart';

List<Day> createCalendarDays({
  required DateTime yearMonth,
  required DayOfWeek startDayOfWeek,
  required List<Holiday> holidays,
}) {
  final startDateInMonth = DateTime(yearMonth.year, yearMonth.month);
  final endDateInMonth = DateTime(yearMonth.year, yearMonth.month + 1, 0);
  final offset = startDayOfWeek.calculateOffset(to: DayOfWeekEx.from(dateTime: startDateInMonth));
  final startDayInCalendar = startDateInMonth.addAmount(dayAmount: -offset);
  final weeksPerCalendar = endDateInMonth.difference(startDayInCalendar).inDays ~/ DateTime.daysPerWeek + 1;
  final calendarDates = List.generate(weeksPerCalendar * DateTime.daysPerWeek, (i) => i).map(
    (i) {
      final date = startDayInCalendar.addAmount(dayAmount: i);
      return Day(
        dateTime: date,
        holidays: holidays.where((holiday) => DateRange.day(day: date).isInRange(holiday.dateRange)).toList(),
        dayInCalendarState:
            yearMonth.month == date.month ? DayInCalendarMonthState.thisMonth : DayInCalendarMonthState.otherMonth,
      );
    },
  ).toList();
  return calendarDates;
}
