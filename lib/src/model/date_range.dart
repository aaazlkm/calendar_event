import 'package:flutter/cupertino.dart';
import 'package:nifu_flutter_kit/nifu_flutter_kit.dart';

@immutable
class DateRange {
  const DateRange.day({
    required DateTime day,
  })  : start = day,
        end = day;

  DateRange.range({
    required DateTime start,
    required DateTime end,
  })  : start = start.isBefore(end) ? start : end,
        end = start.isBefore(end) ? end : start;

  final DateTime start;

  final DateTime end;

  int get diff => end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

  bool get isDay => start.isSameDay(end);

  bool get isRange => !isDay;

  bool isInDate(DateTime other) => start.toUtcLeavingDateAndTime().startDayTime.millisecondsSinceEpoch <= other.millisecondsSinceEpoch && other.toUtcLeavingDateAndTime().tomorrowStartDayTime.millisecondsSinceEpoch < end.toUtcLeavingDateAndTime().tomorrowStartDayTime.millisecondsSinceEpoch;

  bool isInRange(DateRange other) =>
      start.toUtcLeavingDateAndTime().startDayTime.millisecondsSinceEpoch <= other.end.toUtcLeavingDateAndTime().millisecondsSinceEpoch && other.start.toUtcLeavingDateAndTime().millisecondsSinceEpoch < end.toUtcLeavingDateAndTime().tomorrowStartDayTime.millisecondsSinceEpoch;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is DateRange && (other.start == start) && (other.end == end));

  @override
  int get hashCode => runtimeType.hashCode ^ start.hashCode ^ end.hashCode;
}
