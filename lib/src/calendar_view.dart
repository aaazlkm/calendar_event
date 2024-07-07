import 'package:calendar_event/src/collector/day_builder_collector.dart';
import 'package:calendar_event/src/collector/event_builder_collector.dart';
import 'package:calendar_event/src/model/calendar_event.dart';
import 'package:calendar_event/src/model/day_of_week.dart';
import 'package:calendar_event/src/model/holiday.dart';
import 'package:calendar_event/src/view/calendar_month_view.dart';
import 'package:calendar_event/src/view/day_of_weeks_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//region default value
const DayOfWeek kDefaultStartDayOfWeek = DayOfWeek.monday;

const List<Holiday> kDefaultHolidays = [];
//endregion

//region builder
typedef DayOfWeekTextBuilder = Widget Function(BuildContext context, DayOfWeek dayOfWeek);

typedef DividerBuilder = Widget Function(BuildContext context);
//endregion

class CalendarView<Event> extends StatelessWidget {
  const CalendarView({
    required this.yearMonth,
    required this.calendarEvents,
    required this.eventBuilderCollector,
    required this.dayBuilderCollector,
    this.dayOfWeekTextBuilder,
    this.calendarDividerBuilder,
    DayOfWeek? startDayOfWeek,
    List<Holiday>? holidays,
    Key? key,
  })  : startDayOfWeek = startDayOfWeek ?? kDefaultStartDayOfWeek,
        holidays = holidays ?? kDefaultHolidays,
        super(key: key);

  final DateTime yearMonth;

  final List<CalendarEvent<Event>> calendarEvents;

  final EventBuilderCollector<Event> eventBuilderCollector;

  final DayBuilderCollector dayBuilderCollector;

  final DayOfWeekTextBuilder? dayOfWeekTextBuilder;

  final DividerBuilder? calendarDividerBuilder;

  final DayOfWeek startDayOfWeek;

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
              eventBuilderCollector: eventBuilderCollector,
              dayBuilderCollector: dayBuilderCollector,
            ),
          ),
        ],
      );
}
