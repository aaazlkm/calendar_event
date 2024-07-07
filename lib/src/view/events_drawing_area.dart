import 'package:calendar_event/calendar_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDrawingArea<Event> extends StatelessWidget {
  const EventDrawingArea({
    required this.size,
    required this.eventPositionMap,
    required this.eventBuilderCollector,
    Key? key,
  }) : super(key: key);

  final Size size;

  final EventPositionMap<Event> eventPositionMap;

  final EventBuilderCollector<Event> eventBuilderCollector;

  double get eventWidthPerUnit => size.width / DateTime.daysPerWeek;

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none, // オーバーフロー時にクリッピングしない設定
        children: eventPositionMap.eventLines
            .map(
              (eventLine) => Positioned(
                top: eventBuilderCollector.eventHeight * eventLine.horizontalLine.startY,
                left: eventWidthPerUnit * eventLine.horizontalLine.startX,
                width: eventWidthPerUnit * eventLine.horizontalLine.width,
                height: eventBuilderCollector.eventHeight,
                child: eventBuilderCollector.eventBuilder(context, eventLine.event.value),
              ),
            )
            .toList(),
      );
}
