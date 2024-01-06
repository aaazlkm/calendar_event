import 'package:calendar_event/src/ex/date_time_ex.dart';
import 'package:flutter/cupertino.dart';

@immutable
class DateRange {
  const DateRange.day({
    required DateTime day,
  })   : start = day,
        end = day;

  DateRange.range({
    required DateTime start,
    required DateTime end,
  })   : start = start.isBefore(end) ? start : end,
        end = start.isBefore(end) ? end : start;

  final DateTime start;

  final DateTime end;

  int get diff => end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

  bool get isDay => start.isSameDay(end);

  bool get isRange => !isDay;

  bool isInDate(DateTime other) => start.startDayTime.millisecondsSinceEpoch <= other.millisecondsSinceEpoch && other.millisecondsSinceEpoch < end.endDayTime.millisecondsSinceEpoch;

  bool isInRange(DateRange other) => start.startDayTime.millisecondsSinceEpoch <= other.end.millisecondsSinceEpoch && other.start.millisecondsSinceEpoch < end.endDayTime.millisecondsSinceEpoch;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is DateRange && (other.start == start) && (other.end == end));

  @override
  int get hashCode => runtimeType.hashCode ^ start.hashCode ^ end.hashCode;
}
