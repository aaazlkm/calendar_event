// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:calendar_event/calendar_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Date Range Test', () {
    test('Date Range Test', () {
      final dateRange = DateRange.range(start: DateTime(2021, 5, 30), end: DateTime(2021, 6, 5));
      final other = DateRange.day(day: DateTime(2021, 6, 6));
      assert(
        dateRange.isInRange(other) == false,
        '',
      );
    });

    test('Date Range Test', () {
      final dateRange = DateRange.range(start: DateTime(2021, 5, 30), end: DateTime(2021, 6, 5));
      final other = DateRange.day(day: DateTime(2021, 6, 3));
      assert(
        dateRange.isInRange(other) == true,
        '',
      );
    });

    test('Date Range Test', () {
      final dateRange = DateRange.range(start: DateTime(2021, 5, 30), end: DateTime(2021, 6, 5));
      final dateRange2 = DateRange.range(start: DateTime(2021, 6), end: DateTime(2021, 6, 10));
      assert(dateRange.isInRange(dateRange2) == true, '');
    });

    test('Date Range Test', () {
      final dateRange = DateRange.range(start: DateTime(2021, 5, 30), end: DateTime(2021, 6, 5));
      final dateRange2 = DateRange.range(start: DateTime(2021, 6, 6), end: DateTime(2021, 6, 10));
      assert(dateRange.isInRange(dateRange2) == false, '');
    });
  });

  test('Iterable Test', () {
    final list = [1, 2, 3, 4, 5];
    final moreThen2 = list.where((element) => element > 2);
    var count = 0;
    for (final _ in moreThen2) {
      count++;
    }
    expect(count, 3);
  });
}
