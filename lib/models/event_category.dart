import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'event_category.g.dart';

@HiveType(typeId: 3)
enum EventCategory {
  @HiveField(0)
  birthday,
  @HiveField(1)
  school,
  @HiveField(2)
  sports,
  @HiveField(3)
  medical,
  @HiveField(4)
  family,
  @HiveField(5)
  other;

  String get displayName {
    switch (this) {
      case EventCategory.birthday:
        return 'Birthday';
      case EventCategory.school:
        return 'School';
      case EventCategory.sports:
        return 'Sports';
      case EventCategory.medical:
        return 'Medical';
      case EventCategory.family:
        return 'Family';
      case EventCategory.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case EventCategory.birthday:
        return Icons.cake;
      case EventCategory.school:
        return Icons.school;
      case EventCategory.sports:
        return Icons.sports;
      case EventCategory.medical:
        return Icons.medical_services;
      case EventCategory.family:
        return Icons.family_restroom;
      case EventCategory.other:
        return Icons.event;
    }
  }
}
