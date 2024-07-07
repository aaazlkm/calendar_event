import 'package:calendar_event/calendar_event.dart';
import 'package:flutter/material.dart';

class CalendarWeekView<Event> extends StatelessWidget {
  const CalendarWeekView({
    required this.weekDays,
    required this.events,
    required this.eventBuilderCollector,
    required this.dayBuilderCollector,
    super.key,
  });

  final List<Day> weekDays;

  final List<CalendarEvent<Event>> events;

  final EventBuilderCollector<Event> eventBuilderCollector;

  final DayBuilderCollector dayBuilderCollector;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraint) {
          final dayWidth = constraint.maxWidth / DateTime.daysPerWeek;
          return Stack(
            clipBehavior: Clip.none, // オーバーフロー時にクリッピングしない設定
            children: [
              ...weekDays
                  .map(
                    (day) => Positioned(
                      left: dayWidth * weekDays.indexOf(day),
                      top: 0,
                      width: dayWidth,
                      height: constraint.maxHeight,
                      child: _buildDay(context: context, day: day),
                    ),
                  )
                  .toList(),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: dayBuilderCollector.dayTextHeight), // dayTextにかぶらないように
                  child: EventDrawingArea<Event>(
                    size: Size(constraint.maxWidth, constraint.maxHeight),
                    eventPositionMap: createEventPositionMap<Event>(
                      weekDays: weekDays,
                      events: events,
                      maxEventDrawnCountVertically: (constraint.maxHeight - dayBuilderCollector.dayTextHeight) ~/ eventBuilderCollector.eventHeight, // 描画範囲を超えてイベントを描画しない
                    ),
                    eventBuilderCollector: eventBuilderCollector,
                  ),
                ),
              ),
            ],
          );
        },
      );

  Widget _buildDay({
    required BuildContext context,
    required Day day,
  }) =>
      Stack(
        children: [
          Positioned.fill(
            child: dayBuilderCollector.dayBackgroundBuilder?.call(context, day) ?? const SizedBox(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: dayBuilderCollector.dayTextHeight,
              child: Center(child: dayBuilderCollector.dayTextBuilder?.call(context, day) ?? Text(day.dateTime.day.toString())),
            ),
          ),
        ],
      );
}
