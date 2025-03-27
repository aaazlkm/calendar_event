import 'package:calendar_event/calendar_event.dart';
import 'package:calendar_event/src/extensions/date_time_ex.dart';

List<Day> createCalendarDays({
  required DateTime yearMonth,
  required DayOfWeek startDayOfWeek,
  required List<Holiday> holidays,
}) {
  final startDateInMonth = DateTime(yearMonth.year, yearMonth.month);
  final endDateInMonth = DateTime(yearMonth.year, yearMonth.month + 1, 0);
  final offset = startDayOfWeek.calculateOffset(to: DayOfWeekEx.from(dateTime: startDateInMonth));
  final startDayInCalendar = startDateInMonth.addDate(day: -offset);
  final endDayOfWeekInMonth = DayOfWeekEx.from(dateTime: endDateInMonth); //　月の最後の曜日
  final endDayOfWeekInCalendar = startDayOfWeek.previous; // カレンダー内で表示される最後の曜日
  final nextMonthDays = endDayOfWeekInMonth.calculateOffset(to: endDayOfWeekInCalendar); // カレンダー内で表示される次の月の日数
  final addExtraWeek = nextMonthDays <= 2 ? 1 : 0; // 余分に追加する週数。次の月の日数が2以下の場合fabと被るため、余分な週を追加する
  final diff = endDateInMonth
      .addDate(day: 1) // endDateInMonthの分の日付も含めるため
      .toLocalLeavingDateAndTime()
      .difference(startDayInCalendar.toLocalLeavingDateAndTime());
  // 週数
  final weeksPerCalendar = (diff.inDays ~/ DateTime.daysPerWeek) +
      // 切り捨てた場合は、その分一週間増やす
      (diff.inDays % DateTime.daysPerWeek > 0 ? 1 : 0) +
      // 余分な週数
      addExtraWeek;

  final calendarDates = List.generate(weeksPerCalendar * DateTime.daysPerWeek, (i) => i).map(
    (i) {
      final date = startDayInCalendar.addDate(day: i);
      return Day(
        dateTime: date,
        holidays: holidays.where((holiday) => DateRange.day(day: date).isInRange(holiday.dateRange)).toList(),
        dayInCalendarState: yearMonth.month == date.month ? DayInCalendarMonthState.thisMonth : DayInCalendarMonthState.otherMonth,
      );
    },
  ).toList();
  return calendarDates;
}
