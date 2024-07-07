import 'package:calendar_event/calendar_event.dart';

EventPositionMap<Event> createEventPositionMap<Event>({
  required List<Day> weekDays,
  required List<CalendarEvent<Event>> events,
  required int maxEventDrawnCountVertically,
}) {
  final eventPositionMap = EventPositionMap<Event>(maxEventDrawnCountVertically: maxEventDrawnCountVertically);
  final weekDateRange = DateRange.range(start: weekDays.first.dateTime, end: weekDays.last.dateTime);
  final eventsInWeek = events.where((event) => weekDateRange.isInRange(event.dateRange));
  for (final event in eventsInWeek) {
    final startDate = weekDateRange.isInDate(event.dateRange.start) ? event.dateRange.start : weekDateRange.start;
    final endDate = weekDateRange.isInDate(event.dateRange.end) ? event.dateRange.end : weekDateRange.end;
    final startPositionX = startDate.startDayTime.difference(weekDateRange.start.startDayTime).inDays;
    final eventWidth = 1 + endDate.startDayTime.difference(startDate.startDayTime).inDays;
    eventPositionMap.putEventIfAbsent(event, startPositionX, eventWidth);
  }
  return eventPositionMap;
}
