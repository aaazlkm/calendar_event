import 'package:calendar_event/calendar_event.dart';
import 'package:calendar_event/src/factory/calendar_days.dart';
import 'package:calendar_event/src/factory/event_position_map.dart';
import 'package:calendar_event/src/model/calendar_event.dart';
import 'package:calendar_event/src/model/day/day.dart';
import 'package:calendar_event/src/view/events_drawing_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalendarMonthView<Event> extends StatelessWidget {
  CalendarMonthView({
    @required DateTime yearMonth,
    @required this.events,
    @required this.eventBuilder,
    this.dayTextBuilder,
    this.dayBackgroundBuilder,
    this.calendarDividerBuilder,
    DayOfWeek startDayOfWeek,
    List<Holiday> holidays,
    double dayTextHeight,
    double eventHeight,
    Key key,
  })  : calendarDays = createCalendarDays(
          yearMonth: yearMonth,
          startDayOfWeek: startDayOfWeek ?? kDefaultStartDayOfWeek,
          holidays: holidays ?? kDefaultHolidays,
        ),
        eventHeight = eventHeight ?? kDefaultEventHeight,
        dayTextHeight = dayTextHeight ?? kDefaultDayTextHeight,
        super(key: key);

  final List<Day> calendarDays;

  final List<CalendarEvent<Event>> events;

  final EventBuilder<Event> eventBuilder;

  final double dayTextHeight;

  final double eventHeight;

  final DayTextBuilder dayTextBuilder;

  final DayBackgroundBuilder dayBackgroundBuilder;

  final DividerBuilder calendarDividerBuilder;

  @override
  Widget build(BuildContext context) => Column(
        children: List.generate(calendarDays.length ~/ DateTime.daysPerWeek, (index) => index)
            .map(
              (i) => Expanded(
                child: Column(
                  children: [
                    _buildDivider(context: context),
                    Expanded(
                      child: _buildWeek(
                        context: context,
                        weekDays: calendarDays.sublist(DateTime.daysPerWeek * i, DateTime.daysPerWeek * (i + 1)),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      );

  Widget _buildWeek({
    @required BuildContext context,
    @required List<Day> weekDays,
  }) {
    assert(weekDays.length == DateTime.daysPerWeek, 'week dates length must be ${DateTime.daysPerWeek}');
    return Stack(
      children: [
        Positioned.fill(
          child: Row(
            children: weekDays
                .map(
                  (day) => Expanded(
                    child: _buildDay(context: context, day: day),
                  ),
                )
                .toList(),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.only(top: dayTextHeight), // dayTextにかぶらないように
            child: LayoutBuilder(
              builder: (context, constraint) => EventDrawingArea<Event>(
                size: Size(constraint.maxWidth, constraint.maxHeight),
                eventHeight: eventHeight,
                eventPositionMap: createEventPositionMap<Event>(
                  weekDays: weekDays,
                  events: events,
                  maxEventDrawnCountVertically: constraint.maxHeight ~/ eventHeight, // 描画範囲を超えてイベントを描画しない
                ),
                eventBuilder: eventBuilder,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDay({
    @required BuildContext context,
    @required Day day,
  }) =>
      Stack(
        children: [
          Positioned.fill(
            child: dayBackgroundBuilder?.call(context, day) ?? const SizedBox(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: dayTextHeight,
              child: Center(child: dayTextBuilder?.call(context, day) ?? Text(day.dateTime.day.toString())),
            ),
          ),
        ],
      );

  Widget _buildDivider({
    @required BuildContext context,
  }) =>
      calendarDividerBuilder?.call(context) ?? const Divider(height: 1);
}
