import 'dart:math';

import 'package:calendar_event/calendar_event.dart';
import 'package:flutter/material.dart';

import 'model/event.dart';

const colorValue = 300;

List<Color> colors = [
  Colors.red[colorValue]!,
  Colors.pink[colorValue]!,
  Colors.purple[colorValue]!,
  Colors.deepPurple[colorValue]!,
  Colors.indigo[colorValue]!,
  Colors.blue[colorValue]!,
  Colors.lightBlue[colorValue]!,
  Colors.cyan[colorValue]!,
  Colors.teal[colorValue]!,
  Colors.green[colorValue]!,
  Colors.lightGreen[colorValue]!,
  Colors.lime[colorValue]!,
  Colors.yellow[colorValue]!,
  Colors.orange[colorValue]!,
  Colors.grey[colorValue]!,
];

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const CalendarPage(),
      );
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime yearMonth = DateTime.now();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text('${yearMonth.year}年${yearMonth.month}月', style: Theme.of(context).textTheme.headline6),
                ),
              ),
              Expanded(
                child: CalendarView<Event>(
                  yearMonth: yearMonth,
                  startDayOfWeek: DayOfWeek.monday,
                  calendarEvents: dummyCalendarEvent(DateTime.now()) + dummyCalendarEvent(DateTime.now()) + dummyCalendarEvent(DateTime.now()) + dummyCalendarEvent(DateTime.now()),
                  eventBuilder: buildEvent,
                  eventHeight: 20,
                  dayTextBuilder: (_, day) => Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: day.dateTime == DateTime(2021, 1, 30)
                            ? Colors.blue
                            : day.holidays.isEmpty
                                ? Colors.transparent
                                : Colors.red,
                        borderRadius: const BorderRadius.all(Radius.circular(32)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          day.dateTime.day.toString(),
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: day.dateTime == DateTime(2021, 1, 30) ? Colors.white : Colors.black,
                              ),
                        ),
                      ),
                    ),
                  ),
                  dayOfWeekTextBuilder: (context, dayOfWeek) => Text(
                    dayOfWeekText(dayOfWeek),
                    style: dayOfWeek == DayOfWeek.saturday ? Theme.of(context).textTheme.caption?.copyWith(color: Colors.blue) : Theme.of(context).textTheme.caption,
                  ),
                  dayBackgroundBuilder: (_, day) => Material(
                    color: day.dayInCalendarState == DayInCalendarMonthState.thisMonth ? Colors.white : Colors.grey[100],
                    child: InkWell(
                      onTap: () {},
                      splashFactory: InkRipple.splashFactory,
                      child: const Center(),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.arrow_left),
                      onPressed: () {
                        setState(() {
                          yearMonth = DateTime(yearMonth.year, yearMonth.month - 1);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.arrow_right),
                      onPressed: () {
                        setState(() {
                          yearMonth = DateTime(yearMonth.year, yearMonth.month + 1);
                        });
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Widget buildEvent(BuildContext context, Event event) => IgnorePointer(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              color: event.color,
            ),
            child: Center(
              child: Text(
                event.name,
                style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 10, color: Colors.black),
              ),
            ),
          ),
        ),
      );

  String dayOfWeekText(DayOfWeek datOfWeek) {
    switch (datOfWeek) {
      case DayOfWeek.monday:
        return '月';
      case DayOfWeek.tuesday:
        return '火';
      case DayOfWeek.wednesday:
        return '水';
      case DayOfWeek.thursday:
        return '木';
      case DayOfWeek.friday:
        return '金';
      case DayOfWeek.saturday:
        return '土';
      case DayOfWeek.sunday:
        return '日';
    }
    return '';
  }

  List<CalendarEvent<Event>> dummyCalendarEvent(DateTime base) {
    final a = DateTime(2021, 2, 14);
    final today = DateTime(a.year, a.month, a.day + Random().nextInt(15) - Random().nextInt(15));

    final ranges = List.generate(
      20,
      (index) => CalendarEvent<Event>(
        value: Event('予定$index', colors[Random().nextInt(colors.length)]),
        dateRange: DateRange.range(
          start: DateTime(today.year, today.month, today.day + Random().nextInt(5) - Random().nextInt(5)),
          end: DateTime(today.year, today.month, today.day + Random().nextInt(5) - Random().nextInt(5)),
        ),
      ),
    );

    return ranges;
  }
}
