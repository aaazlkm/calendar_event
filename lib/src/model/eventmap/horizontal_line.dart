import 'package:calendar_event/src/model/eventmap/position.dart';
import 'package:flutter/foundation.dart';

@immutable
class HorizontalLine {
  HorizontalLine({
    required this.start,
    required this.end,
  }) : assert(start.x <= end.x && start.y == end.y, 'must be from.x <= to.x & equal y position');

  final Position start;

  final Position end;

  int get width => (end.x - start.x) + 1;

  List<Position> get positions => List.generate(width, (i) => i)
      .map(
        (i) => Position(x: start.x + i, y: start.y),
      )
      .toList();

  int get startX => start.x;

  int get startY => start.y;

  int get endX => end.x;

  int get endY => end.y;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is HorizontalLine && (other.start == start) && (other.end == end));

  @override
  int get hashCode => runtimeType.hashCode ^ start.hashCode ^ end.hashCode;
}
