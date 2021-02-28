import 'package:calendar_event/src/model/calendar_event.dart';
import 'package:calendar_event/src/model/day/day.dart';
import 'package:calendar_event/src/model/day_of_week.dart';
import 'package:calendar_event/src/model/holiday.dart';
import 'package:calendar_event/src/view/calendar_month_view.dart';
import 'package:calendar_event/src/view/day_of_weeks_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//region default value
const DayOfWeek kDefaultStartDayOfWeek = DayOfWeek.monday;

const double kDefaultDayTextHeight = 24;

const double kDefaultEventHeight = 16;

const List<Holiday> kDefaultHolidays = [];
//endregion

//region builder
typedef DayOfWeekTextBuilder = Widget Function(BuildContext context, DayOfWeek dayOfWeek);

typedef DayTextBuilder = Widget Function(BuildContext context, Day day);

typedef DayBackgroundBuilder = Widget Function(BuildContext context, Day day);

typedef DividerBuilder = Widget Function(BuildContext context);

typedef EventBuilder<Event> = Widget Function(BuildContext context, Event event);
//endregion

class CalendarView<Event> extends StatelessWidget {
  const CalendarView({
    @required this.yearMonth,
    @required this.calendarEvents,
    @required this.eventBuilder,
    this.dayOfWeekTextBuilder,
    this.dayTextBuilder,
    this.dayBackgroundBuilder,
    this.calendarDividerBuilder,
    DayOfWeek startDayOfWeek,
    double dayTextHeight,
    double eventHeight,
    List<Holiday> holidays,
    Key key,
  })  : startDayOfWeek = startDayOfWeek ?? kDefaultStartDayOfWeek,
        dayTextHeight = dayTextHeight ?? kDefaultDayTextHeight,
        eventHeight = eventHeight ?? kDefaultEventHeight,
        holidays = holidays ?? kDefaultHolidays,
        super(key: key);

  final DateTime yearMonth;

  final List<CalendarEvent<Event>> calendarEvents;

  final EventBuilder<Event> eventBuilder;

  final DayOfWeekTextBuilder dayOfWeekTextBuilder;

  final DividerBuilder calendarDividerBuilder;

  final DayTextBuilder dayTextBuilder;

  final DayBackgroundBuilder dayBackgroundBuilder;

  final DayOfWeek startDayOfWeek;

  final double dayTextHeight;

  final double eventHeight;

  final List<Holiday> holidays;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 8),
          DayOfWeeksView(
            startDayOfWeek: startDayOfWeek,
            dayOfWeekTextBuilder: dayOfWeekTextBuilder,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: CalendarMonthView<Event>(
              yearMonth: yearMonth,
              startDayOfWeek: startDayOfWeek,
              holidays: holidays,
              events: calendarEvents,
              eventBuilder: eventBuilder,
              dayTextHeight: dayTextHeight,
              eventHeight: eventHeight,
              dayTextBuilder: dayTextBuilder,
              dayBackgroundBuilder: dayBackgroundBuilder,
            ),
          ),
        ],
      );
}
