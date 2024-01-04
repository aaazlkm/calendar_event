import 'package:calendar_event/calendar_event.dart';
import 'package:flutter/foundation.dart';

@immutable
class Day {
  const Day({
    required this.dateTime,
    required this.holidays,
    required this.dayInCalendarState,
  });

  final DateTime dateTime;

  final List<Holiday> holidays;

  final DayInCalendarMonthState dayInCalendarState;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Day && (other.dateTime == dateTime) && (listEquals(other.holidays, holidays)) && (other.dayInCalendarState == dayInCalendarState));

  @override
  int get hashCode => runtimeType.hashCode ^ dateTime.hashCode ^ holidays.hashCode ^ dayInCalendarState.hashCode;
}
