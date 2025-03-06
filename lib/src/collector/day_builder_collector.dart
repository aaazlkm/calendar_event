import 'package:calendar_event/calendar_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

typedef DayTextBuilder = Widget Function(BuildContext context, Day day);

typedef DayBackgroundBuilder = Widget Function(BuildContext context, Day day);

/// Dayのビルドに関する情報をまとめたクラス
class DayBuilderCollector extends Equatable {
  const DayBuilderCollector({
    required this.dayTextBuilder,
    required this.dayBackgroundBuilder,
  });

  final DayTextBuilder? dayTextBuilder;

  final DayBackgroundBuilder? dayBackgroundBuilder;

  @override
  List<Object?> get props => [dayTextBuilder, dayBackgroundBuilder];
}
