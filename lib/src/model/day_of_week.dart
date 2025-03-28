enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension DayOfWeekEx on DayOfWeek {
  static DayOfWeek from({required DateTime dateTime}) {
    switch (dateTime.weekday) {
      case DateTime.monday:
        return DayOfWeek.monday;
      case DateTime.tuesday:
        return DayOfWeek.tuesday;
      case DateTime.wednesday:
        return DayOfWeek.wednesday;
      case DateTime.thursday:
        return DayOfWeek.thursday;
      case DateTime.friday:
        return DayOfWeek.friday;
      case DateTime.saturday:
        return DayOfWeek.saturday;
      case DateTime.sunday:
        return DayOfWeek.sunday;
    }
    return DayOfWeek.sunday;
  }

  List<DayOfWeek> get dayOfWeeksStartThis {
    const dayOfWeeks = DayOfWeek.values;
    final index = dayOfWeeks.indexOf(this);
    return dayOfWeeks.sublist(index) + dayOfWeeks.sublist(0, index);
  }

  int calculateOffset({required DayOfWeek to}) => dayOfWeeksStartThis.indexOf(to);

  /// 次の曜日
  DayOfWeek get next {
    final index = DayOfWeek.values.indexOf(this);
    return DayOfWeek.values[(index + 1) % DayOfWeek.values.length];
  }

  /// 前の曜日
  DayOfWeek get previous {
    final index = DayOfWeek.values.indexOf(this);
    return DayOfWeek.values[(index - 1) % DayOfWeek.values.length];
  }
}
