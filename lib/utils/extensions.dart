import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
}

extension DateTimeExt on DateTime {
  /// midnight in local timezone
  DateTime get atMidnight => DateTime(year, month, day);

  /// Days between two midnights, never negative
  int sleepsUntil(DateTime other) =>
      other.atMidnight.difference(atMidnight).inDays.clamp(0, 999);
}
