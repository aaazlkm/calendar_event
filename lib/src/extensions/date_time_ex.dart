extension DateTimeEx on DateTime {
  /// 00:00:00.000のDateTimeを取得
  DateTime get startDayTime {
    if (isUtc) {
      return DateTime.utc(year, month, day);
    } else {
      return DateTime(year, month, day);
    }
  }

  /// 次の日の00:00:00.000のDateTimeを取得
  DateTime get tomorrowStartDayTime {
    if (isUtc) {
      return DateTime.utc(year, month, day + 1);
    } else {
      return DateTime(year, month, day + 1);
    }
  }

  /// 同じ年かどうか
  bool isSameYear(DateTime other) => year == other.year;

  /// 同じ月かどうか
  bool isSameMonth(DateTime other) => isSameYear(other) && month == other.month;

  /// 同じ日かどうか
  bool isSameDay(DateTime other) => isSameMonth(other) && day == other.day;

  /// 日付上書きする
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    if (isUtc) {
      return DateTime.utc(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second ?? this.second,
        millisecond ?? this.millisecond,
        microsecond ?? this.microsecond,
      );
    } else {
      return DateTime(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second ?? this.second,
        millisecond ?? this.millisecond,
        microsecond ?? this.microsecond,
      );
    }
  }

  /// 日付を加算する
  DateTime addDate({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    if (isUtc) {
      return DateTime.utc(
        this.year + (year ?? 0),
        this.month + (month ?? 0),
        this.day + (day ?? 0),
        this.hour + (hour ?? 0),
        this.minute + (minute ?? 0),
        this.second + (second ?? 0),
        this.millisecond + (millisecond ?? 0),
        this.microsecond + (microsecond ?? 0),
      );
    } else {
      return DateTime(
        this.year + (year ?? 0),
        this.month + (month ?? 0),
        this.day + (day ?? 0),
        this.hour + (hour ?? 0),
        this.minute + (minute ?? 0),
        this.second + (second ?? 0),
        this.millisecond + (millisecond ?? 0),
        this.microsecond + (microsecond ?? 0),
      );
    }
  }

  /// ローカルタイムの日時をそのままUTCの日時に変換する。
  /// 時差を考慮しないことに注意、つまりtoUtcと異なることに注意。
  ///
  /// 例
  /// 2024/05/13 09:00:00+09:00に`toUtcLeavingDateAndTime`を呼ぶと、2024/05/13 09:00:00+00:00となる。
  DateTime toUtcLeavingDateAndTime() {
    if (isUtc) {
      return this;
    } else {
      return DateTime.utc(year, month, day, hour, minute, second, millisecond, microsecond);
    }
  }

  /// UTCの日時をそのままローカルタイムの日時に変換する。
  /// 時差を考慮しないことに注意、つまりtoLocalと異なることに注意。
  ///
  /// 例
  /// 2024/05/13 09:00:00+00:00に`toLocalLeavingDateAndTime`を呼ぶと、2024/05/13 09:00:00+09:00となる。
  DateTime toLocalLeavingDateAndTime() {
    if (isUtc) {
      return DateTime(year, month, day, hour, minute, second, millisecond, microsecond);
    } else {
      return this;
    }
  }
}
