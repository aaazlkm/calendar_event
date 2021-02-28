import 'package:calendar_event/src/model/date_range.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Holiday {
  const Holiday({
    @required this.name,
    @required this.dateRange,
  });

  final String name;

  final DateRange dateRange;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is Holiday && (other.name == name) && (other.dateRange == dateRange));

  @override
  int get hashCode => runtimeType.hashCode ^ name.hashCode ^ dateRange.hashCode;
}
