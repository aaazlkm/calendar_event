import 'package:calendar_event/calendar_event.dart';
import 'package:flutter/material.dart';

class CalendarMonthView<Event> extends StatelessWidget {
  CalendarMonthView({
    required DateTime yearMonth,
    required this.events,
    required this.eventBuilderCollector,
    required this.dayBuilderCollector,
    this.calendarDividerBuilder,
    DayOfWeek? startDayOfWeek,
    List<Holiday>? holidays,
    Key? key,
  })  : calendarDays = createCalendarDays(
          yearMonth: yearMonth,
          startDayOfWeek: startDayOfWeek ?? kDefaultStartDayOfWeek,
          holidays: holidays ?? kDefaultHolidays,
        ),
        super(key: key);

  final List<Day> calendarDays;

  final List<CalendarEvent<Event>> events;

  final EventBuilderCollector<Event> eventBuilderCollector;

  final DayBuilderCollector dayBuilderCollector;

  final DividerBuilder? calendarDividerBuilder;

  @override
  Widget build(BuildContext context) => Column(
        children: List.generate(calendarDays.length ~/ DateTime.daysPerWeek, (index) => index)
            .map(
              (i) => Expanded(
                child: Column(
                  children: [
                    _buildDivider(context: context),
                    Expanded(
                      child: CalendarWeekView<Event>(
                        weekDays: calendarDays.sublist(DateTime.daysPerWeek * i, DateTime.daysPerWeek * (i + 1)),
                        events: events,
                        eventBuilderCollector: eventBuilderCollector,
                        dayBuilderCollector: dayBuilderCollector,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      );

  Widget _buildDivider({
    required BuildContext context,
  }) =>
      calendarDividerBuilder?.call(context) ?? const Divider(height: 1);
}
