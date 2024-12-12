import 'package:calendar_event/src/model/day_of_week.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DayOfWeek extensions', () {
    test('next method returns the correct next day', () {
      expect(DayOfWeek.monday.next, DayOfWeek.tuesday);
      expect(DayOfWeek.tuesday.next, DayOfWeek.wednesday);
      expect(DayOfWeek.wednesday.next, DayOfWeek.thursday);
      expect(DayOfWeek.thursday.next, DayOfWeek.friday);
      expect(DayOfWeek.friday.next, DayOfWeek.saturday);
      expect(DayOfWeek.saturday.next, DayOfWeek.sunday);
      expect(DayOfWeek.sunday.next, DayOfWeek.monday); // Wrap around
    });

    test('previous method returns the correct previous day', () {
      expect(DayOfWeek.monday.previous, DayOfWeek.sunday); // Wrap around
      expect(DayOfWeek.tuesday.previous, DayOfWeek.monday);
      expect(DayOfWeek.wednesday.previous, DayOfWeek.tuesday);
      expect(DayOfWeek.thursday.previous, DayOfWeek.wednesday);
      expect(DayOfWeek.friday.previous, DayOfWeek.thursday);
      expect(DayOfWeek.saturday.previous, DayOfWeek.friday);
      expect(DayOfWeek.sunday.previous, DayOfWeek.saturday);
    });

    test('index wraparound for negative values', () {
      // -1 % 7 = 6になるんだ。
      final result = (0 - 1) % DayOfWeek.values.length;
      expect(result, DayOfWeek.values.length - 1);
    });
  });
}
