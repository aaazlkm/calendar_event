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

  /// _CalendarWeekViewStackだけを使用したいが、Stackを使用すると描画が遅い
  /// そのため、7日以内の場合は_CalendarWeekViewRowを使用する
  @override
  Widget build(BuildContext context) => weekDays.length > 7
      ? _CalendarWeekViewStack<Event>(
          weekDays: weekDays,
          events: events,
          eventBuilderCollector: eventBuilderCollector,
          dayBuilderCollector: dayBuilderCollector,
        )
      : _CalendarWeekViewRow<Event>(
          weekDays: weekDays,
          events: events,
          eventBuilderCollector: eventBuilderCollector,
          dayBuilderCollector: dayBuilderCollector,
        );
}

class _CalendarWeekViewStack<Event> extends StatelessWidget {
  const _CalendarWeekViewStack({
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
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none, // オーバーフロー時にクリッピングしない設定
        children: [
          // Dayの背景
          Positioned.fill(
            child: LayoutBuilder(
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
                            child: DayBackground(
                              day: day,
                              dayBuilderCollector: dayBuilderCollector,
                            ),
                          ),
                        )
                        .toList(),
                  ],
                );
              },
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                /// Dayのテキスト
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      /// 曜日の高さを計算するためのテキスト
                      /// 非表示描画し、DayOfWeeksViewの高さを計算する
                      Visibility(
                        visible: false,
                        maintainAnimation: true,
                        maintainState: true,
                        maintainSize: true,
                        child: DayText(
                          day: weekDays.first,
                          dayBuilderCollector: dayBuilderCollector,
                        ),
                      ),
                      Positioned.fill(
                        child: LayoutBuilder(
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
                                        child: DayText(
                                          day: day,
                                          dayBuilderCollector: dayBuilderCollector,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                /// Event
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraint) => EventDrawingArea<Event>(
                      size: Size(constraint.maxWidth, constraint.maxHeight),
                      eventPositionMap: createEventPositionMap<Event>(
                        weekDays: weekDays,
                        events: events,
                        maxEventDrawnCountVertically: constraint.maxHeight ~/ eventBuilderCollector.eventHeight, // 描画範囲を超えてイベントを描画しない
                      ),
                      eventBuilderCollector: eventBuilderCollector,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

class _CalendarWeekViewRow<Event> extends StatelessWidget {
  const _CalendarWeekViewRow({
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
  Widget build(BuildContext context) => Stack(
        children: [
          Row(
            children: weekDays
                .map(
                  (day) => Expanded(
                    child: DayBackground(
                      day: day,
                      dayBuilderCollector: dayBuilderCollector,
                    ),
                  ),
                )
                .toList(),
          ),
          Column(
            children: [
              Row(
                children: weekDays
                    .map(
                      (day) => Expanded(
                        child: DayText(
                          day: day,
                          dayBuilderCollector: dayBuilderCollector,
                        ),
                      ),
                    )
                    .toList(),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraint) => EventDrawingArea<Event>(
                    size: Size(constraint.maxWidth, constraint.maxHeight),
                    eventBuilderCollector: eventBuilderCollector,
                    eventPositionMap: createEventPositionMap<Event>(
                      weekDays: weekDays,
                      events: events,
                      maxEventDrawnCountVertically: constraint.maxHeight ~/ eventBuilderCollector.eventHeight, // 描画範囲を超えてイベントを描画しない
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}

class DayBackground extends StatelessWidget {
  const DayBackground({
    required this.day,
    required this.dayBuilderCollector,
    super.key,
  });

  final Day day;

  final DayBuilderCollector dayBuilderCollector;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Positioned.fill(
            child: dayBuilderCollector.dayBackgroundBuilder?.call(context, day) ?? const SizedBox(),
          ),
        ],
      );
}

class DayText extends StatelessWidget {
  const DayText({
    required this.day,
    required this.dayBuilderCollector,
    super.key,
  });

  final Day day;

  final DayBuilderCollector dayBuilderCollector;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 20), // 最低の高さを設定
        child: Center(
          child: dayBuilderCollector.dayTextBuilder?.call(context, day) ?? Text(day.dateTime.day.toString()),
        ),
      );
}
