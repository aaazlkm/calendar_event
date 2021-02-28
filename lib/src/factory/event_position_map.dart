import 'package:calendar_event/calendar_event.dart';
import 'package:calendar_event/src/ex/date_time_ex.dart';
import 'package:calendar_event/src/model/calendar_event.dart';
import 'package:calendar_event/src/model/day/day.dart';
import 'package:calendar_event/src/model/eventmap/event_position_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

EventPositionMap<Event> createEventPositionMap<Event>({
  @required List<Day> weekDays,
  @required List<CalendarEvent<Event>> events,
  @required int maxEventDrawnCountVertically,
}) {
  final eventPositionMap = EventPositionMap<Event>(maxEventDrawnCountVertically: maxEventDrawnCountVertically);
  final weekDateRange = DateRange.range(start: weekDays.first.dateTime, end: weekDays.last.dateTime);
  final weekEvents = events.where((event) => weekDateRange.isInRange(event.dateRange));
  final weekEventRange = weekEvents.where((event) => event.dateRange.isRange).toList()
    ..sort(
      (a, b) => b.dateRange.diff.compareTo(a.dateRange.diff),
    );
  final weekEventDay = weekEvents.where((event) => event.dateRange.isDay).toList()
    ..sort(
      (a, b) => a.dateRange.start.millisecondsSinceEpoch.compareTo(b.dateRange.start.millisecondsSinceEpoch),
    );
  for (final event in weekEventRange + weekEventDay) {
    final startDate = weekDateRange.isInDate(event.dateRange.start) ? event.dateRange.start : weekDateRange.start;
    final endDate = weekDateRange.isInDate(event.dateRange.end) ? event.dateRange.end : weekDateRange.end;
    final startPositionX = startDate.difference(weekDateRange.start).inDays;
    final eventWidth = endDate.startDayTime.difference(startDate.startDayTime).inDays + 1;
    eventPositionMap.putEventIfAbsent(event, startPositionX, eventWidth);
  }
  return eventPositionMap;
}
