import 'package:calendar_event/calendar_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

const double kDefaultDayTextHeight = 24;

typedef DayTextBuilder = Widget Function(BuildContext context, Day day);

typedef DayBackgroundBuilder = Widget Function(BuildContext context, Day day);

/// Dayのビルドに関する情報をまとめたクラス
class DayBuilderCollector extends Equatable {
  const DayBuilderCollector({
    required this.dayTextBuilder,
    required this.dayBackgroundBuilder,
    this.dayTextHeight = kDefaultDayTextHeight,
  });

  final double dayTextHeight;

  final DayTextBuilder? dayTextBuilder;

  final DayBackgroundBuilder? dayBackgroundBuilder;

  @override
  List<Object?> get props => [dayTextHeight, dayTextBuilder, dayBackgroundBuilder];
}
