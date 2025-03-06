import 'package:calendar_event/calendar_event.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// 曜日のテキスト
class DayOfWeeksView extends StatelessWidget {
  DayOfWeeksView({
    required this.startDayOfWeek,
    this.dayOfWeekTextBuilder,
    List<DayOfWeek>? overrideDayOfWeekList,
    Key? key,
  })  :
        // [overrideDayOfWeekList]が指定されている場合はそのリストを使用する。10日分表示したい場合があるため。
        dayOfWeekList = overrideDayOfWeekList ?? startDayOfWeek.dayOfWeeksStartThis,
        super(key: key);

  final DayOfWeek startDayOfWeek;

  final List<DayOfWeek> dayOfWeekList;

  final DayOfWeekTextBuilder? dayOfWeekTextBuilder;

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              /// 曜日の高さを計算するためのテキスト
              /// 非表示描画し、DayOfWeeksViewの高さを計算する
              Visibility(
                visible: false,
                maintainAnimation: true,
                maintainState: true,
                maintainSize: true,
                child: _buildDayOfWeekText(
                  context: context,
                  dayOfWeek: DayOfWeek.sunday,
                ),
              ),
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final dayWidth = constraints.maxWidth / DateTime.daysPerWeek;
                    return Stack(
                      clipBehavior: Clip.none, // オーバーフロー時にクリッピングしない設定
                      children: dayOfWeekList
                          .mapIndexed(
                            (index, dayOfWeek) => Positioned(
                              left: dayWidth * index,
                              top: 0,
                              width: dayWidth,
                              height: constraints.maxHeight,
                              child: Center(
                                  child: _buildDayOfWeekText(
                                context: context,
                                dayOfWeek: dayOfWeek,
                              )),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildDayOfWeekText({
    required BuildContext context,
    required DayOfWeek dayOfWeek,
  }) =>
      dayOfWeekTextBuilder?.call(context, dayOfWeek) ??
      Text(
        _getDayOfWeekText(dayOfWeek),
        style: Theme.of(context).textTheme.bodyMedium,
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
}
