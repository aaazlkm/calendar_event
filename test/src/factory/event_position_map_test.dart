import 'package:calendar_event/calendar_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('createEventPositionMap', () {
    final baseDate = DateTime.utc(2024, 1, 1); // 月曜日から始まる週
    final weekDays = List.generate(
      7,
      (index) => Day(
        dateTime: baseDate.add(Duration(days: index)),
        holidays: [],
        dayInCalendarState: DayInCalendarMonthState.thisMonth,
      ),
    );
    const maxEventDrawnCountVertically = 3;

    test('異なるタイムゾーンのイベントでも正しい位置が計算される', () {
      final events = [
        CalendarEvent(
          value: 'utc',
          dateRange: DateRange.range(
            start: DateTime.utc(2024, 1, 2),
            end: DateTime.utc(2024, 1, 2),
          ),
        ),
        CalendarEvent(
          value: 'jst',
          dateRange: DateRange.range(
            start: DateTime(2024, 1, 2),
            end: DateTime(2024, 1, 2),
          ),
        ),
      ];

      final result = createEventPositionMap(
        weekDays: weekDays,
        events: events,
        maxEventDrawnCountVertically: maxEventDrawnCountVertically,
      );

      // 同じ日付のイベントは同じX位置になるべき
      expect(result.eventLines[0].horizontalLine.startX, 1); // 1月2日は週の2日目
    });

    test('週をまたぐイベントの境界値テスト', () {
      final events = [
        // 前の週のイベント
        CalendarEvent(
          value: 'prev_week_start',
          dateRange: DateRange.range(
            start: baseDate.subtract(const Duration(days: 2)),
            end: baseDate.subtract(const Duration(days: 1)),
          ),
        ),
        // 週の初めから始まるイベント
        CalendarEvent(
          value: 'week_start',
          dateRange: DateRange.range(
            start: baseDate,
            end: baseDate.add(const Duration(days: 2)),
          ),
        ),
        // 週の終わりまで続くイベント
        CalendarEvent(
          value: 'week_end',
          dateRange: DateRange.range(
            start: baseDate.add(const Duration(days: 5)),
            end: baseDate.add(const Duration(days: 6)),
          ),
        ),
        // 週をまたぐイベント（前の週から）
        CalendarEvent(
          value: 'cross_prev_week',
          dateRange: DateRange.range(
            start: baseDate.subtract(const Duration(days: 2)),
            end: baseDate.add(const Duration(days: 1)),
          ),
        ),
        // 週をまたぐイベント（次の週まで）
        CalendarEvent(
          value: 'cross_next_week',
          dateRange: DateRange.range(
            start: baseDate.add(const Duration(days: 5)),
            end: baseDate.add(const Duration(days: 8)),
          ),
        ),
        // 次の週のイベント
        CalendarEvent(
          value: 'next_week_end',
          dateRange: DateRange.range(
            start: baseDate.add(const Duration(days: 8)),
            end: baseDate.add(const Duration(days: 9)),
          ),
        ),
      ];

      final result = createEventPositionMap(
        weekDays: weekDays,
        events: events,
        maxEventDrawnCountVertically: maxEventDrawnCountVertically,
      );

      // 前の週のイベント -> 描画されない

      // 週の初めから始まるイベント
      expect(result.eventLines[0].horizontalLine.startX, 0);
      expect(result.eventLines[0].horizontalLine.width, 3);

      // 週の終わりまで続くイベント
      expect(result.eventLines[1].horizontalLine.startX, 5);
      expect(result.eventLines[1].horizontalLine.width, 2);

      // 週をまたぐイベント（前の週から）
      expect(result.eventLines[2].horizontalLine.startX, 0);
      expect(result.eventLines[2].horizontalLine.width, 2);

      // 週をまたぐイベント（次の週まで）
      expect(result.eventLines[3].horizontalLine.startX, 5);
      expect(result.eventLines[3].horizontalLine.width, 2);

      // 次の週のイベント
    });

    test('maxEventDrawnCountVerticallyを超えるイベントの配置テスト', () {
      final events = List.generate(
        5, // maxEventDrawnCountVertically(3)より多い
        (index) => CalendarEvent(
          value: 'event_$index',
          dateRange: DateRange.range(
            start: baseDate,
            end: baseDate,
          ),
        ),
      );

      final result = createEventPositionMap(
        weekDays: weekDays,
        events: events,
        maxEventDrawnCountVertically: maxEventDrawnCountVertically,
      );

      // 最初の3つのイベントは表示される
      for (var i = 0; i < maxEventDrawnCountVertically; i++) {
        expect(result.eventLines[i], isNotNull);
        expect(result.eventLines[i].horizontalLine.startY, i);
      }

      // 範囲外のインデックスにアクセスするとRangeErrorが発生することを確認 -> つまり描画されない
      expect(
        () => result.eventLines[events.length - 1],
        throwsA(isA<RangeError>()),
      );
    });
  });
}
