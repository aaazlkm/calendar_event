import 'package:calendar_event/calendar_event.dart';

class EventPositionMap<Event> {
  EventPositionMap({
    required this.maxEventDrawnCountVertically,
  });

  final int maxEventDrawnCountVertically;

  final Map<Position, CalendarEvent<Event>> _positionToEvent = {};

  final List<EventLine<Event>> _eventLines = [];

  List<EventLine<Event>> get eventLines => _eventLines;

  void putEventIfAbsent(CalendarEvent<Event> event, int startPositionX, int eventWidth) {
    final horizontalLine = _calculateDrawableLine(startPositionX, eventWidth);
    if (horizontalLine != null) {
      final eventLine = EventLine<Event>(horizontalLine: horizontalLine, event: event);
      _putEvent(eventLine);
    }
  }

  /// 描画できない場合、nullを返す
  HorizontalLine? _calculateDrawableLine(int startPositionX, int eventWidth) {
    for (final positionY in List.generate(maxEventDrawnCountVertically, (i) => i)) {
      final canDrawableEvent = _canDrawableEvent(eventWidth, startPositionX, positionY);
      if (canDrawableEvent) {
        return HorizontalLine(
          start: Position(x: startPositionX, y: positionY),
          end: Position(x: startPositionX + (eventWidth - 1), y: positionY),
        );
      }
    }
    return null;
  }

  bool _canDrawableEvent(int eventWidth, int startPositionX, int positionY) => List.generate(eventWidth, (i) => i)
      .map((offsetX) => Position(x: startPositionX + offsetX, y: positionY))
      .map<bool>((position) => _positionToEvent[position] == null)
      .fold<bool>(true, (previousValue, element) => previousValue && element);

  void _putEvent(EventLine<Event> eventLine) {
    for (final position in eventLine.horizontalLine.positions) {
      _positionToEvent[position] = eventLine.event;
    }
    _eventLines.add(eventLine);
  }
}
