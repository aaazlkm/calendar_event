import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

const double kDefaultEventHeight = 16;

typedef EventBuilder<Event> = Widget Function(BuildContext context, Event event);

/// Eventのビルドに関する情報を保持するクラス
class EventBuilderCollector<Event> extends Equatable {
  const EventBuilderCollector({
    required this.eventBuilder,
    this.eventHeight = kDefaultEventHeight,
  });

  final double eventHeight;

  final EventBuilder<Event> eventBuilder;

  @override
  List<Object?> get props => [eventHeight, eventBuilder];
}
