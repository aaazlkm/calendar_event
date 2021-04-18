import 'package:calendar_event/src/model/date_range.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CalendarEvent<T> {
  const CalendarEvent({
    required this.value,
    required this.dateRange,
  });

  final T value;

  final DateRange dateRange;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is CalendarEvent && (other.value == value) && (other.dateRange == dateRange));

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode ^ dateRange.hashCode;
}
