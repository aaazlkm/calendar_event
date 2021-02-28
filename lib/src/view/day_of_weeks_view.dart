import 'package:calendar_event/calendar_event.dart';
import 'package:calendar_event/src/model/day_of_week.dart';
import 'package:flutter/material.dart';

class DayOfWeeksView extends StatelessWidget {
  const DayOfWeeksView({
    @required this.startDayOfWeek,
    this.dayOfWeekTextBuilder,
    Key key,
  }) : super(key: key);

  final DayOfWeek startDayOfWeek;

  final DayOfWeekTextBuilder dayOfWeekTextBuilder;

  @override
  Widget build(BuildContext context) => Row(
        children: startDayOfWeek.dayOfWeeksStartThis
            .map(
              (dayOfWeek) => Expanded(
                child: Center(
                  child: dayOfWeekTextBuilder?.call(context, dayOfWeek) ?? Text(_getDayOfWeekText(dayOfWeek), style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
            )
            .toList(),
      );
}

String _getDayOfWeekText(DayOfWeek dayOfWeek) {
  switch (dayOfWeek) {
    case DayOfWeek.sunday:
      return 'sun';
    case DayOfWeek.monday:
      return 'mon';
    case DayOfWeek.tuesday:
      return 'tue';
    case DayOfWeek.wednesday:
      return 'wed';
    case DayOfWeek.thursday:
      return 'thu';
    case DayOfWeek.friday:
      return 'fri';
    case DayOfWeek.saturday:
      return 'sat';
  }
  throw AssertionError('unknown type: $dayOfWeek');
}
