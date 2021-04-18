import 'package:calendar_event/calendar_event.dart';
import 'package:calendar_event/src/model/eventmap/event_position_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDrawingArea<Event> extends StatelessWidget {
  const EventDrawingArea({
    required this.size,
    required this.eventHeight,
    required this.eventPositionMap,
    required this.eventBuilder,
    Key? key,
  }) : super(key: key);

  final Size size;

  final double eventHeight;

  final EventPositionMap<Event> eventPositionMap;

  final EventBuilder<Event> eventBuilder;

  double get eventWidthPerUnit => size.width / DateTime.daysPerWeek;

  @override
  Widget build(BuildContext context) => Stack(
        children: eventPositionMap.eventLines
            .map(
              (eventLine) => Positioned(
                top: eventHeight * eventLine.horizontalLine.startY,
                left: eventWidthPerUnit * eventLine.horizontalLine.startX,
                width: eventWidthPerUnit * eventLine.horizontalLine.width,
                height: eventHeight,
                child: eventBuilder(context, eventLine.event.value),
              ),
            )
            .toList(),
      );
}
