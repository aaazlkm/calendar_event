import 'package:flutter/widgets.dart';

@immutable
class Position {
  const Position({
    @required this.x,
    @required this.y,
  });

  final int x;

  final int y;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is Position && (other.x == x) && (other.y == y));

  @override
  int get hashCode => runtimeType.hashCode ^ x ^ y;
}
