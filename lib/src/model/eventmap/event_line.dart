import 'package:calendar_event/src/model/calendar_event.dart';
import 'package:calendar_event/src/model/eventmap/horizontal_line.dart';
import 'package:flutter/widgets.dart';

@immutable
class EventLine<Event> {
  const EventLine({
    required this.horizontalLine,
    required this.event,
  });

  final HorizontalLine horizontalLine;

  final CalendarEvent<Event> event;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is EventLine && (other.horizontalLine == horizontalLine) && (other.event == event));

  @override
  int get hashCode => runtimeType.hashCode ^ horizontalLine.hashCode ^ event.hashCode;
}
